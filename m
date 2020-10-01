Subject: Rebuild fails on with below error when "core-image-minimal is retriggered from the same work space
To: bitbake-devel@lists.openembedded.org
From: "Virendra Kumar" <coolveer07@gmail.com>
X-Originating-Location: Chennai, Tamil Nadu, IN (106.208.106.112)
X-Originating-Platform: Windows Chrome 85
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 01 Oct 2020 00:51:19 -0700
Message-ID: <HJNo.1601538679572857394.FwMe@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="mBMi048NT91QcXm7hEtC"

--mBMi048NT91QcXm7hEtC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Loaded 4863 entries from dependency cache.
ERROR: Command execution failed: Traceback (most recent call last):
File "openembedded-core/bitbake/lib/bb/command.py", line 103, in runAsyncC=
ommand
self.cooker.updateCache()
File "openembedded-core/bitbake/lib/bb/cooker.py", line 1562, in updateCac=
he
self.parser =3D CookerParser(self, filelist, masked)
File "openembedded-core/bitbake/lib/bb/cooker.py", line 2006, in __init__
if not self.bb_cache.cacheValid(filename, appends):
File "openembedded-core/bitbake/lib/bb/cache.py", line 551, in cacheValid
self.cacheValidUpdate(fn, appends)
File "openembedded-core/bitbake/lib/bb/cache.py", line 619, in cacheValidU=
pdate
f, exist =3D f.split(":")
ValueError: too many values to unpack (expected 2)

Summary: There were 5 WARNING messages shown.
Summary: There was 1 ERROR message shown, returning a non-zero exit code.

--mBMi048NT91QcXm7hEtC
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Loaded 4863 entries from dependency cache.</div>
<div>ERROR: Command execution failed: Traceback (most recent call last):</=
div>
<div>&nbsp;File "openembedded-core/bitbake/lib/bb/command.py", line 103, i=
n runAsyncCommand</div>
<div>&nbsp;self.cooker.updateCache()</div>
<div>&nbsp;File "openembedded-core/bitbake/lib/bb/cooker.py", line 1562, i=
n updateCache</div>
<div>&nbsp;self.parser =3D CookerParser(self, filelist, masked)</div>
<div>&nbsp;File "openembedded-core/bitbake/lib/bb/cooker.py", line 2006, i=
n __init__</div>
<div>&nbsp;if not self.bb_cache.cacheValid(filename, appends):</div>
<div>&nbsp;File "openembedded-core/bitbake/lib/bb/cache.py", line 551, in =
cacheValid</div>
<div>&nbsp;self.cacheValidUpdate(fn, appends)</div>
<div>&nbsp;File "openembedded-core/bitbake/lib/bb/cache.py", line 619, in =
cacheValidUpdate</div>
<div>&nbsp;f, exist =3D f.split(":")</div>
<div>ValueError: too many values to unpack (expected 2)</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Summary: There were 5 WARNING messages shown.</div>
<div>Summary: There was 1 ERROR message shown, returning a non-zero exit c=
ode.</div>

--mBMi048NT91QcXm7hEtC--
