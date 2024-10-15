import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchWidget extends StatefulWidget {
  const StopwatchWidget({super.key});

  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  late Timer _timer; // Timer object
  DateTime? _startTime; // Start time
  Duration _elapsedTime = Duration.zero; // Total elapsed time
  List<String> _lapTimes = []; // List to hold lap times
  bool _isRunning = false; // Timer state
  bool _isPaused = false; // Pause state

  void _startTimer() {
    if (!_isRunning) {
      _startTime = DateTime.now().subtract(_elapsedTime);
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {
          // Update UI at each tick
          _elapsedTime = DateTime.now().difference(_startTime!);
        });
      });
      _isRunning = true;
      _isPaused = false;
    }
  }

  void _pauseTimer() {
    _stopTimer(); // Stop the timer
    setState(() {
      _isPaused = true; // Update pause state
    });
  }

  void _resumeTimer() {
    _startTimer(); // Resume the timer
    setState(() {
      _isPaused = false; // Update pause state
    });
  }

  void _stopTimer() {
    _timer.cancel(); // Stop the timer
    _isRunning = false; // Update the running state
  }

  void _resetTimer() {
    _stopTimer(); // Stop the timer
    setState(() {
      _elapsedTime = Duration.zero; // Reset elapsed time
      _lapTimes.clear(); // Clear lap times
      _isPaused = false; // Reset pause state
    });
  }

  void _recordLap() {
    if (_isRunning) {
      _lapTimes.add(_formattedDuration(_elapsedTime)); // Record lap time
      setState(() {}); // Refresh UI to show the new lap
    }
  }

  String _formattedDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitsMilliseconds(int n) => (n ~/ 10).toString().padLeft(2, '0');

    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    String milliseconds =
        twoDigitsMilliseconds(duration.inMilliseconds.remainder(1000));

    return '$minutes:$seconds.$milliseconds';
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child: Container(
                width: 200,
                // Width of the circular stopwatch
                height: 200,
                // Height of the circular stopwatch
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                alignment: Alignment.center,
                child: Text(
                  _formattedDuration(_elapsedTime), // Display formatted time
                  style: const TextStyle(
                    fontSize: 30, // Font size for the time
                    color: Colors.white, // Text color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Start Button
              if (!_isRunning &&
                  !_isPaused) // Show Start button when timer is not running
                ElevatedButton(
                  onPressed: _startTimer,
                  child: const Text('Start'),
                )
              else if (_isPaused) // Show Resume button only when paused
                ElevatedButton(
                  onPressed: _resumeTimer,
                  child: const Text('Resume'),
                ),
              const SizedBox(width: 10),
              // Stop Button (only shown when the timer is running)
              if (_isRunning)
                ElevatedButton(
                  onPressed: _pauseTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Stop',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              const SizedBox(width: 10),
              // Lap / Reset Button
              ElevatedButton(
                onPressed: _isRunning ? _recordLap : _resetTimer,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: Text(_isRunning ? 'Lap' : 'Reset'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: _lapTimes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Lap ${index + 1}: ${_lapTimes[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
