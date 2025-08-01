/*
    Persistent Markers C++ Extension
    Description: C++ extension for enhanced marker persistence functionality
    Author: Your Name
    Version: 1.0
*/

#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <json/json.h>

#ifdef _WIN32
    #define EXPORT __declspec(dllexport)
#else
    #define EXPORT
#endif

// Structure to hold marker data
struct MarkerData {
    std::string name;
    std::vector<double> position;
    std::string type;
    std::string text;
    std::string color;
    std::vector<double> size;
    double direction;
    std::string shape;
    std::string brush;
    double alpha;
};

// Export function for saving markers to JSON file (backup method)
extern "C" EXPORT int saveMarkersToFile(const char* filePath, const char* markerDataJson) {
    try {
        Json::Value root;
        Json::Reader reader;

        if (!reader.parse(markerDataJson, root)) {
            return 0; // Failed to parse JSON
        }

        std::ofstream file(filePath);
        if (!file.is_open()) {
            return 0; // Failed to open file
        }

        Json::StreamWriterBuilder builder;
        builder["indentation"] = "  ";
        std::unique_ptr<Json::StreamWriter> writer(builder.newStreamWriter());
        writer->write(root, &file);

        file.close();
        return 1; // Success
    }
    catch (...) {
        return 0; // Error occurred
    }
}

// Export function for loading markers from JSON file (backup method)
extern "C" EXPORT const char* loadMarkersFromFile(const char* filePath) {
    try {
        std::ifstream file(filePath);
        if (!file.is_open()) {
            return nullptr; // Failed to open file
        }

        Json::Value root;
        Json::Reader reader;

        if (!reader.parse(file, root)) {
            file.close();
            return nullptr; // Failed to parse JSON
        }

        file.close();

        Json::StreamWriterBuilder builder;
        std::string* result = new std::string();
        std::ostringstream stream;
        std::unique_ptr<Json::StreamWriter> writer(builder.newStreamWriter());
        writer->write(root, &stream);
        *result = stream.str();

        return result->c_str();
    }
    catch (...) {
        return nullptr; // Error occurred
    }
}

// Export function for validating marker data
extern "C" EXPORT int validateMarkerData(const char* markerDataJson) {
    try {
        Json::Value root;
        Json::Reader reader;

        if (!reader.parse(markerDataJson, root)) {
            return 0; // Invalid JSON
        }

        if (!root.isArray()) {
            return 0; // Should be an array of markers
        }

        for (const auto& marker : root) {
            if (!marker.isArray() || marker.size() != 10) {
                return 0; // Each marker should have 10 elements
            }
        }

        return 1; // Valid
    }
    catch (...) {
        return 0; // Error occurred
    }
}
