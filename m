Subject: Need Recommendation: adding tests for a fetch scheme
To: bitbake-devel@lists.openembedded.org
From: "Sourabh Banerjee" <sbanerje@codeaurora.org>
X-Originating-Location: Bengaluru, Karnataka, IN (122.167.21.228)
X-Originating-Platform: Windows Chrome 90
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 18 May 2021 08:42:56 -0700
Message-ID: <KYHW.1621352576055088553.tlxB@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="Mef0dI2sbntlbMnfvKBE"

--Mef0dI2sbntlbMnfvKBE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I submitted a few patches for enhancing the repo fetcher on this list.
Can I get some pointer how and where I should enhance the tests to add tes=
ts for repo fetcher?

I looked at=C2=A0lib/bb/tests/fetch.py, seems this implements tests for va=
rious fetch schemes.
Shall I start by adding the 'repo' to=C2=A0test_uris dict in=C2=A0class UR=
ITest?
What are nuances.

Some pointer will be great help!

--Mef0dI2sbntlbMnfvKBE
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I submitted a few patches for enhancing the repo fetcher on this list.<br /=
>Can I get some pointer how and where I should enhance the tests to add tes=
ts for repo fetcher?<br /><br />I looked at&nbsp;lib/bb/tests/fetch.py, see=
ms this implements tests for various fetch schemes.<br />Shall I start by a=
dding the 'repo' to&nbsp;test_uris dict in&nbsp;class URITest?<br />What ar=
e nuances.<br /><br />Some pointer will be great help!

--Mef0dI2sbntlbMnfvKBE--
