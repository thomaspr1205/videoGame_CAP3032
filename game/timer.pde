class Timer{
    int startTime, stopTime, totalTime;

    // start timer
    void start(){
        startTime = millis();
    }

    // stops times
    void stop(){
        stopTime = millis();
        totalTime = stopTime - startTime;
    }

    // get time in seconds
    int seconds(){
        return (totalTime/1000) % 60;
    }

    // get time in minutes
    int minutes(){
        return (totalTime/ (1000*60)) % 60;
    }
}