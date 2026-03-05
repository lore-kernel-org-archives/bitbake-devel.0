Return-Path: <pedro.ms.ferreira@ctw.bmwgroup.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9AF3092D
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 10:22:41 +0000 (UTC)
Subject: Re: [PATCH] fetch2: avoid reuse download filenames
To: bitbake-devel@lists.openembedded.org
From: pedro.ms.ferreira@ctw.bmwgroup.com
X-Originating-Location: Porto, PT (213.205.68.221)
X-Originating-Platform: Linux Chrome 145
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 02:22:40 -0800
References: <20260302151443.256386-1-pedro.ms.ferreira@ctw.bmwgroup.com> <e58fedf42052698a50007bd5d49a70e0b77aa702.camel@linuxfoundation.org>
In-Reply-To: <e58fedf42052698a50007bd5d49a70e0b77aa702.camel@linuxfoundation.org>
Message-ID: <245205.1772706160236503925@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="ZAJ1UPpxUEvO6HD6j6R4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 10:22:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19108

--ZAJ1UPpxUEvO6HD6j6R4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I tested a few scenarios to be sure that this is not blocking or changing b=
ehavior apart from the one use case that im trying to fix.

Use case 1
- No local file
- Two mirrors with the source file:
- Mirror 1: 7da977765ddfe7a38e72905d6e2ae71b
- Mirror 2: 12e597833772126eade44740570aab3c
- Recipe points SRC_URI to 12e597833772126eade44740570aab3c
- PREMIRRORS appended with both http servers

bitbake -C fetch local-test - Succeeds
---------------------------------------------------------------------------=
------------------------
WARNING: local-test-1.0-r0 do_fetch: Checksum mismatch for local file (...)=
 /yocto-downloads/test_download.tar.gz
Cleaning and trying again.
WARNING: local-test-1.0-r0 do_fetch: Renaming (...)/yocto-downloads/ test_d=
ownload.tar.gz to (...) /yocto-downloads/ test_download.tar.gz_bad-checksum=
_f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8156a3d4949f7de67fc87
WARNING: local-test-1.0-r0 do_fetch: Checksum failure encountered with prem=
irror download of http://0.0.0.0:1234/ test_download.tar.gz - will attempt =
other sources.
---------------------------------------------------------------------------=
------------------------

Use case 2
- No local file
- Two mirrors with the source file:
- Mirror 1: 7da977765ddfe7a38e72905d6e2ae71b
- Mirror 2: 7da977765ddfe7a38e72905d6e2ae71b
- Recipe points SRC_URI to 12e597833772126eade44740570aab3c
- PREMIRRORS appended with both http servers

bitbake -C fetch local-test - Fails
---------------------------------------------------------------------------=
------------------------
ERROR: local-test-1.0-r0 do_fetch: Fetcher failure for URL: 'http://0.0.0.0=
:1234/test_download.tar.gz'. Checksum mismatch!
File: '(...)/yocto-downloads/test_download.tar.gz.tmp' has sha256 checksum =
'f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8156a3d4949f7de67fc87' when '0f=
27e2d871ee8ae4784e4461ea2c35190df94ec8e8b07caba80056b2520999e1' was expecte=
d
If this change is expected (e.g. you have upgraded to a new version without=
 updating the checksums) then you can use these lines within the recipe:
SRC_URI[sha256sum] =3D "f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8156a3d4=
949f7de67fc87"
Otherwise you should retry the download and/or check with upstream to deter=
mine if the file has become corrupted or otherwise unexpectedly modified.
ERROR: local-test-1.0-r0 do_fetch: Bitbake Fetcher Error: FetchError('Unabl=
e to fetch URL from any source.', 'http://0.0.0.0:1234/test_download.tar.gz=
')
ERROR: Logfile of failure stored in:(...)/qemux86-64/build/tmp/work/core2-6=
4-poky-linux/local-test/1.0/temp/log.do_fetch.13826
ERROR: Task (.../local-test/local-test.bb:do_fetch) failed with exit code '=
1'
---------------------------------------------------------------------------=
------------------------

Use case 3 (Target scenario with the patch proposed)
- Local file (7da977765ddfe7a38e72905d6e2ae71b)
- Two mirrors with the source file:
- Mirror 1: 12e597833772126eade44740570aab3c
- Mirror 2: 12e597833772126eade44740570aab3c
- Recipe points SRC_URI to 12e597833772126eade44740570aab3c
- PREMIRRORS appended with both http servers

bitbake -C fetch local-test - Fails
---------------------------------------------------------------------------=
------------------------
ERROR: local-test-1.0-r0 do_fetch: Checksum mismatch for local file (...)/y=
octo-downloads/test_download.tar.gz
ERROR: Logfile of failure stored in: (...)/qemux86-64/build/tmp/work/core2-=
64-poky-linux/local-test/1.0/temp/log.do_fetch.28967
ERROR: Task (.../local-test/local-test.bb:do_fetch) failed with exit code '=
1'
---------------------------------------------------------------------------=
------------------------

I think this covers at least the most common cases, imho it makes sense to =
block any attempt of users to overwrite old source files,
and this should be user responsibility to fix the recipe.
If you have any other use case in mind please let me know.

Cheers.

--ZAJ1UPpxUEvO6HD6j6R4
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi Richard,</div>
<div>&nbsp;</div>
<div>I tested a few scenarios to be sure that this is not blocking or chang=
ing behavior apart from the one use case that im trying to fix.</div>
<div>&nbsp;</div>
<div>Use case 1</div>
<div>- No local file</div>
<div>- Two mirrors with the source file:</div>
<div>&nbsp;- Mirror 1: 7da977765ddfe7a38e72905d6e2ae71b</div>
<div>&nbsp;- Mirror 2: 12e597833772126eade44740570aab3c</div>
<div>- Recipe points SRC_URI to 12e597833772126eade44740570aab3c</div>
<div>- <span data-teams=3D"true">PREMIRRORS appended with both http servers=
</span></div>
<div>&nbsp;</div>
<div><span data-teams=3D"true">bitbake -C fetch local-test - Succeeds</span=
><span data-teams=3D"true"></span></div>
<div><span data-teams=3D"true">--------------------------------------------=
-------------------------------------------------------</span></div>
<div><span data-teams=3D"true">WARNING: local-test-1.0-r0 do_fetch: Checksu=
m mismatch for local file <span data-teams=3D"true">(...)</span>/yocto-down=
loads/test_download.tar.gz<br />Cleaning and trying again.<br />WARNING: lo=
cal-test-1.0-r0 do_fetch: Renaming (...)/yocto-downloads/<span data-teams=
=3D"true">test_download</span>.tar.gz to <span data-teams=3D"true">(...)</s=
pan>/yocto-downloads/<span data-teams=3D"true">test_download</span>.tar.gz_=
bad-checksum_f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8156a3d4949f7de67fc=
87<br />WARNING: local-test-1.0-r0 do_fetch: Checksum failure encountered w=
ith premirror download of http://0.0.0.0:1234/<span data-teams=3D"true">tes=
t_download</span>.tar.gz - will attempt other sources.</span></div>
<div>----------------------------------------------------------------------=
-----------------------------</div>
<div>&nbsp;</div>
<div>
<div>Use case 2</div>
<div>- No local file</div>
<div>- Two mirrors with the source file:</div>
<div>&nbsp;- Mirror 1: 7da977765ddfe7a38e72905d6e2ae71b</div>
<div>&nbsp;- Mirror 2: 7da977765ddfe7a38e72905d6e2ae71b</div>
<div>- Recipe points SRC_URI to 12e597833772126eade44740570aab3c</div>
<div>- <span data-teams=3D"true">PREMIRRORS appended with both http servers=
</span></div>
<div>&nbsp;</div>
<div><span data-teams=3D"true">bitbake -C fetch local-test - Fails</span><s=
pan data-teams=3D"true"></span></div>
<div><span data-teams=3D"true">--------------------------------------------=
-------------------------------------------------------</span></div>
<div>ERROR: local-test-1.0-r0 do_fetch: Fetcher failure for URL: 'http://0.=
0.0.0:1234/test_download.tar.gz'. Checksum mismatch!<br />File: '(...)/yoct=
o-downloads/test_download.tar.gz.tmp' has sha256 checksum 'f03e325aa451beda=
1b340a7ce0fcfd620b74c86e12b8156a3d4949f7de67fc87' when '0f27e2d871ee8ae4784=
e4461ea2c35190df94ec8e8b07caba80056b2520999e1' was expected<br />If this ch=
ange is expected (e.g. you have upgraded to a new version without updating =
the checksums) then you can use these lines within the recipe:<br />SRC_URI=
[sha256sum] =3D "f03e325aa451beda1b340a7ce0fcfd620b74c86e12b8156a3d4949f7de=
67fc87"<br />Otherwise you should retry the download and/or check with upst=
ream to determine if the file has become corrupted or otherwise unexpectedl=
y modified.<br />ERROR: local-test-1.0-r0 do_fetch: Bitbake Fetcher Error: =
FetchError('Unable to fetch URL from any source.', 'http://0.0.0.0:1234/tes=
t_download.tar.gz')<br />ERROR: Logfile of failure stored in:(...)/qemux86-=
64/build/tmp/work/core2-64-poky-linux/local-test/1.0/temp/log.do_fetch.1382=
6<br />ERROR: Task (.../local-test/local-test.bb:do_fetch) failed with exit=
 code '1'</div>
<div>----------------------------------------------------------------------=
-----------------------------</div>
<div>&nbsp;</div>
<div>Use case 3 (Target scenario with the patch proposed)</div>
<div>
<div>- Local file (7da977765ddfe7a38e72905d6e2ae71b)</div>
<div>- Two mirrors with the source file:</div>
<div>&nbsp;- Mirror 1: 12e597833772126eade44740570aab3c</div>
<div>&nbsp;- Mirror 2: 12e597833772126eade44740570aab3c</div>
<div>- Recipe points SRC_URI to 12e597833772126eade44740570aab3c</div>
<div>- <span data-teams=3D"true">PREMIRRORS appended with both http servers=
</span></div>
<div>&nbsp;</div>
<div><span data-teams=3D"true"><span data-teams=3D"true">bitbake -C fetch l=
ocal-test - Fails</span></span></div>
<div><span data-teams=3D"true"><span data-teams=3D"true">------------------=
---------------------------------------------------------------------------=
------</span></span></div>
</div>
<div>ERROR: local-test-1.0-r0 do_fetch: Checksum mismatch for local file (.=
..)/yocto-downloads/test_download.tar.gz<br />ERROR: Logfile of failure sto=
red in: (...)/qemux86-64/build/tmp/work/core2-64-poky-linux/local-test/1.0/=
temp/log.do_fetch.28967<br />ERROR: Task (.../local-test/local-test.bb:do_f=
etch) failed with exit code '1'</div>
</div>
<div>----------------------------------------------------------------------=
-----------------------------</div>
<div>&nbsp;</div>
<div>I think this covers at least the most common cases, imho it makes sens=
e to block any attempt of users to overwrite old source files,</div>
<div>and this should be user responsibility to fix the recipe.</div>
<div>If you have any other use case in mind please let me know.</div>
<div>&nbsp;</div>
<div>Cheers.</div>

--ZAJ1UPpxUEvO6HD6j6R4--

