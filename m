Subject: Migrating yocto project from sumo to warrior - getting null registry error from npm
To: bitbake-devel@lists.openembedded.org
From: christopher.mcclellan95@gmail.com
X-Originating-Location: Valencia, California, US (198.72.131.105)
X-Originating-Platform: Windows Firefox 76
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 12 May 2020 17:41:54 -0700
Message-ID: <2sbt.1589330514952552942.tTjp@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="A0vIeexnEuudWutFCgvd"

--A0vIeexnEuudWutFCgvd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I'm migrating a yocto project that is working on sumo to warrior, so I set =
my layers to be the "warrior" branches. Everything runs fine until it fails=
 in my node project layer on "do_compile" with the error message "Cannot re=
ad property 'replace' of null." It seems to return null for npm.config.get(=
'registry'), but it is set on the Docker image that's building this image. =
If I delete the npm-shrinkwrap.json, it builds, but I'd like to leave that =
file in for the project. I think I need to either upgrade the npm version t=
o 6.10.3 (where this error was fixed) or set the npm registry for the build=
 process. How would I do that?

--A0vIeexnEuudWutFCgvd
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I'm migrating a yocto project that is working on sumo to warrior, so I set =
my layers to be the "warrior" branches. Everything runs fine until it fails=
 in my node project layer on "do_compile" with the error message "Cannot re=
ad property 'replace' of null." It seems to return null for npm.config.get(=
'registry'), but it is set on the Docker image that's building this image. =
If I delete the npm-shrinkwrap.json, it builds, but I'd like to leave that =
file in for the project. I think I need to either upgrade the npm version t=
o 6.10.3 (where this error was fixed) or set the npm registry for the build=
 process. How would I do that?

--A0vIeexnEuudWutFCgvd--
