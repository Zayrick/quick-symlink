// Draws the DMG window background: an SF Symbols arrow from the app icon to the Applications folder.
//
//   swift Scripts/dmg/background.swift <output-dir>
//
// Writes background.png and background@2x.png; the layout must match Scripts/dmg/settings.py.
import AppKit

let size = CGSize(width: 640, height: 400)
let arrowCenter = CGPoint(x: 320, y: 190) // from the top, like Finder icon positions

func draw(in context: CGContext) {
    NSGraphicsContext.current = NSGraphicsContext(cgContext: context, flipped: false)

    let gradient = NSGradient(starting: NSColor(srgbRed: 0.98, green: 0.98, blue: 0.99, alpha: 1),
                              ending: NSColor(srgbRed: 0.91, green: 0.93, blue: 0.96, alpha: 1))!
    gradient.draw(in: CGRect(origin: .zero, size: size), angle: -90)

    let configuration = NSImage.SymbolConfiguration(pointSize: 48, weight: .medium)
        .applying(NSImage.SymbolConfiguration(hierarchicalColor: NSColor(srgbRed: 0.55, green: 0.58, blue: 0.64, alpha: 1)))
    let arrow = NSImage(systemSymbolName: "arrow.right", accessibilityDescription: nil)!.withSymbolConfiguration(configuration)!
    let origin = CGPoint(x: arrowCenter.x - arrow.size.width / 2, y: size.height - arrowCenter.y - arrow.size.height / 2)
    arrow.draw(in: CGRect(origin: origin, size: arrow.size))
}

func render(scale: CGFloat, to url: URL) {
    let width = Int(size.width * scale), height = Int(size.height * scale)
    let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0,
                            space: CGColorSpace(name: CGColorSpace.sRGB)!,
                            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    context.scaleBy(x: scale, y: scale)
    draw(in: context)

    let destination = CGImageDestinationCreateWithURL(url as CFURL, "public.png" as CFString, 1, nil)!
    let dpi = 72 * scale
    CGImageDestinationAddImage(destination, context.makeImage()!, [
        kCGImagePropertyDPIWidth: dpi, kCGImagePropertyDPIHeight: dpi,
    ] as CFDictionary)
    CGImageDestinationFinalize(destination)
}

let output = URL(fileURLWithPath: CommandLine.arguments.dropFirst().first ?? ".")
render(scale: 1, to: output.appendingPathComponent("background.png"))
render(scale: 2, to: output.appendingPathComponent("background@2x.png"))
