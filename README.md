# Bowling Game (ignorant solution)

This attempt at scoring a Bowling Game came from attending a software craftmenship session at SkillMatter. Titled ["Readable and Intention Revealing Code](http://skillsmatter.com/podcast/home/readable-and-intention-revealing-coder) this session was based upon the Bowling Game Kata.

This solution is ignorant because it uses very little of the original Kata. I didn't want to be influenced too much by the Kata (I hope to study this aftewards). However I did pick up from it the idea that the LastFrame is different from other Frames, and probably also the idea that Frame is a seperate class.

One of my biggest problems with this problem was not understanding how bowling scoring works. In the session at Skill Matter I had no idea about this. This made it very difficult to reveal intentions with any clarity. With hindsight this is pretty obvious, but in these sorts of events one tends to skim the specs and get stuck in.

Having worked on this solution (and read about bowling scoring on Wikipedia) a few things stand out

- a game consists of ten frames
- each frame has a maximum score of 30
- the last frame is different from the rest
- if a frame is a strike or a spare its score will be dependent on subsequent rolls

On the technical side making the roll method return self (for Game and Frame) is very useful - you can do game.roll(5).roll(6).

Normally I like to use the commit log to document the history of my code. This project is a really poor example of this. Lack of clear intentions and rushing are partly to blame.


