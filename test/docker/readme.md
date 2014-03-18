# Running unit and other tests under docker

1. Enter the VM
```
docker run -i -t -v `pwd`/../../:/bouncer:rw robbinsd/bouncertest /bin/bash
```
2. ``cd bouncer``
3. ``npm install``
4. ``bower --allow-root install``
5. ``npm test`` runs the unit tests.
