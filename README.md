#  ImageMemory

So, I've made a number of stylistic changes/improvements:

1. Put the call to `UIActivityViewController` inside the block requesting permission to the photos library. Not only is this probably preferable (we don't want to allow them to try to save to their photo library at all if they haven't granted permission), but offers a nice way to profile the app both with and without the `UIActivityViewController` (by either granting or denying permissions to the photos library).

2. In `replaceImage`, bypass the round-trip to `PNG` data when setting `testImgView1.image`. This more memory efficient.

3. Removed `autoreleasepool` because that only makes sense if done within a loop; when you yield back to the run loop, the pool is automatically drained, so `autoreleasepool` is redundant.

4. Generally tidied up the code:

 * Alignment;
 * remove redundant `CGSize` calls;
 * added some "points of interest" logging (shown as Ⓢ in below images);
 * etc.
 
Anyway, now that I've moved the `UIActivityViewController` inside the check for permission, I can easily check the memory usage both without permission (i.e.  `UIActivityViewController`  not used): 

![Image](test/Images/Instruments%20snapshots/WithoutPermission.png)

And with permission (i.e.  `UIActivityViewController`  not used).

![With permission](test/Images/Instruments%20snapshots/WithPermission.png)

Each of those "Ⓢ" signposts was me tapping the "merge" button. As you can see, the former shows no material growth in memory and the latter shows very modest growth.

---

If you're still seeing memory growth, I'd make sure you do a release build and make sure your scheme doesn't have any logging options turned on (e.g. zombies or the like).
