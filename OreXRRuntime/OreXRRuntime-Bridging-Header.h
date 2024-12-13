//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#define XR_USE_GRAPHICS_API_METAL

#include "openxr/openxr.h"
#include "openxr/openxr_platform.h"
#include "openxr/openxr_loader_negotiation.h"

// TODO: we should NOT write these in header file
const char OREXR_EXTNAME_XR_KHR_metal_enable[XR_MAX_EXTENSION_NAME_SIZE] = XR_KHR_METAL_ENABLE_EXTENSION_NAME;
const char OREXR_SYSTEM_NAME[XR_MAX_SYSTEM_NAME_SIZE] = "OreXR System";
const char OREXR_RUNTIME_NAME[XR_MAX_RUNTIME_NAME_SIZE] = "OreXR Runtime";
