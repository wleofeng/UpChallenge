# UpChallenge


# What is it?

UpChallenge is an iOS application that's built to help you exercise without a gym trainer. 

# How does it work? 

The application uses `AVSpeechsynthesizer` API to dictate workout instructions. You just need to follow along. 

Workout instructions are configurable, using a JSON payload. Currently this is maintained in the `lyrics.json` file.

Payload example: 
```
{  
   "name":"Sally Up",  // name of the workout
   "lyrics":[  
      {  
         "time":1, // at timer equals to 1 second, the application will dictate this line of lyric 
         "lyric":"Bring Sally up and bring Sally down. Lift and squat, gotta tear the ground."
      },
      {  
         "time":10,
         "lyric":"Bring Sally up and bring Sally down. Lift and squat, gotta tear the ground."
      }
   ]
}
```

Note - Before opening the project, in command line, make sure to run `pod install`.


# Why did I build this?

I was inspired by the Sally Up Challenge.

https://www.youtube.com/watch?v=41N6bKO-NVI


# Future plans 

- Send JSON payload from a backend server 
- Support storing multiple workout payloads  




