import AppKit

func usage() {
	let name = URL(fileURLWithPath: CommandLine.arguments[0]).lastPathComponent
	print("usage: \(name) [generic|alignment|levelchange]")
}

func main() -> Int32 {
	guard #available(OSX 10.11, *) else {
		print("error: haptic requires macOS 10.11 or higher")
		return 1
	}
		
	let pattern: NSHapticFeedbackPattern
	let arg = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "generic"
	switch arg {
		case "generic":
			pattern = NSHapticFeedbackPattern.generic
		case "alignment":
			pattern = NSHapticFeedbackPattern.alignment
		case "levelchange":
			pattern = NSHapticFeedbackPattern.levelChange
		case "help", "--help", "-h":
			usage()
			return 0
		default:
			print("error: unknown haptic pattern \(arg)")
			usage()
			return 1
	}

	let fm = NSHapticFeedbackManager.defaultPerformer()
	fm.perform(pattern, performanceTime: NSHapticFeedbackPerformanceTime.now)
	return 0
}

exit(main())
