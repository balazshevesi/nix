#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/hidsystem/IOHIDLib.h>
#include <IOKit/hidsystem/IOHIDParameter.h>
#include <IOKit/IOKitLib.h>
#include <mach/mach.h>
#include <stdio.h>
#include <stdlib.h>

static int set_acceleration(io_connect_t connection, CFStringRef key, double value) {
  kern_return_t result = IOHIDSetAccelerationWithKey(connection, key, value);
  if (result != KERN_SUCCESS) {
    char buffer[128];
    CFStringGetCString(key, buffer, sizeof(buffer), kCFStringEncodingUTF8);
    fprintf(stderr, "failed to set %s to %.4f: 0x%x\n", buffer, value, result);
    return 1;
  }

  return 0;
}

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr, "usage: %s <acceleration>\n", argv[0]);
    return 64;
  }

  char *end = NULL;
  double value = strtod(argv[1], &end);
  if (end == argv[1] || *end != '\0') {
    fprintf(stderr, "invalid acceleration: %s\n", argv[1]);
    return 64;
  }

  io_service_t service = IOServiceGetMatchingService(kIOMainPortDefault, IOServiceMatching(kIOHIDSystemClass));
  if (service == MACH_PORT_NULL) {
    fprintf(stderr, "failed to find %s\n", kIOHIDSystemClass);
    return 1;
  }

  io_connect_t connection = MACH_PORT_NULL;
  kern_return_t result = IOServiceOpen(service, mach_task_self(), kIOHIDParamConnectType, &connection);
  IOObjectRelease(service);
  if (result != KERN_SUCCESS) {
    fprintf(stderr, "failed to open %s: 0x%x\n", kIOHIDSystemClass, result);
    return 1;
  }

  int status = 0;
  status |= set_acceleration(connection, CFSTR(kIOHIDMouseAccelerationType), value);
  status |= set_acceleration(connection, CFSTR(kIOHIDTrackpadAccelerationType), value);

  IOServiceClose(connection);
  return status;
}
