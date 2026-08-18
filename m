Return-Path: <WXbet@proton.me>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF801C5DF81
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 19:39:10 +0000 (UTC)
Subject: [PATCH] knotty: show elapsed time on the task progress bar
To: bitbake-devel@lists.openembedded.org
From: "WXbet" <WXbet@proton.me>
X-Originating-Location: Hohenhameln, Lower Saxony, DE (94.31.114.216)
X-Originating-Platform: Windows Edge 151
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 12:39:04 -0700
Message-ID: <sCTK.1787081944669538524.zSRd@lists.openembedded.org>
Content-Type: multipart/mixed; boundary="D8qpGTQGdahWdWZKuozP"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 19:39:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19984

--D8qpGTQGdahWdWZKuozP
Content-Type: multipart/alternative; boundary="5KIlhiY5nlAuaXBKCarS"

--5KIlhiY5nlAuaXBKCarS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

As a convenience for the user, this makes it easy to see at a glance how lo=
ng
the current build has already been running.

The progress bar for the overall build currently shows only a percentage an=
d
a bar, with no running time =E2=80=94 while each individual running-task li=
ne below
it already carries an elapsed-time value. The patch adds a Timer widget to
the bar, reusing knotty's existing time formatting so it matches the rest o=
f
the UI.

Thanks,
WXbet

--5KIlhiY5nlAuaXBKCarS
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">As a convenience for the user, this makes it easy to see at =
a glance how long<br />the current build has already been running.</p>
<p dir=3D"ltr">The progress bar for the overall build currently shows only =
a percentage and<br />a bar, with no running time &mdash; while each indivi=
dual running-task line below<br />it already carries an elapsed-time value.=
 The patch adds a Timer widget to<br />the bar, reusing knotty's existing t=
ime formatting so it matches the rest of<br />the UI.</p>
<p dir=3D"ltr">Thanks,<br />WXbet</p>

--5KIlhiY5nlAuaXBKCarS--

--D8qpGTQGdahWdWZKuozP
Content-Type: application/octet-stream; name="0001-knotty-show-elapsed-time-on-the-task-progress-bar.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-knotty-show-elapsed-time-on-the-task-progress-bar.patch"

RnJvbSA5MzAyZTg1ZTc1ZWRjNmFmMjJlYTkwMzM2ZDJiMGM0NmZhOTVmZTgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXWGJldCA8NTczMTQ1MTArV1hiZXRAdXNlcnMubm9yZXBseS5n
aXRodWIuY29tPgpEYXRlOiBUdWUsIDE4IEF1ZyAyMDI2IDIxOjMwOjIyICswMjAwClN1YmplY3Q6
IFtQQVRDSF0ga25vdHR5OiBzaG93IGVsYXBzZWQgdGltZSBvbiB0aGUgdGFzayBwcm9ncmVzcyBi
YXIKClRoZSBwcm9ncmVzcyBiYXIgZm9yIHRoZSBvdmVyYWxsIGJ1aWxkIHNob3dzIGEgcGVyY2Vu
dGFnZSBhbmQgYSBiYXIgYnV0IG5vCmVsYXBzZWQgdGltZSwgZXZlbiB0aG91Z2ggdGhlIGluZGl2
aWR1YWwgcnVubmluZy10YXNrIGxpbmVzIGJlbG93IGl0IGVhY2gKc2hvdyBvbmUuCgpBZGQgYSBU
aW1lciB3aWRnZXQgdG8gdGhlIGJhci4gVGhlIHRpbWUgZm9ybWF0dGluZyBpbgpUZXJtaW5hbEZp
bHRlci5lbGFwc2VkKCkgaXMgaG9pc3RlZCB0byBhIG1vZHVsZS1sZXZlbCBiYl9lbGFwc2VkKCkg
aGVscGVyIGFuZApyZXVzZWQgYnkgYSBzbWFsbCBwcm9ncmVzc2Jhci5UaW1lciBzdWJjbGFzcywg
c28gdGhlIGJhciBwcmludHMgdGhlIHNhbWUKIiVkaCVkbSVkcyIgc3R5bGUgYXMgdGhlIHJlc3Qg
b2YgdGhlIFVJLgoKU2lnbmVkLW9mZi1ieTogV1hiZXQgPDU3MzE0NTEwK1dYYmV0QHVzZXJzLm5v
cmVwbHkuZ2l0aHViLmNvbT4KLS0tCiBsaWIvYmIvdWkva25vdHR5LnB5IHwgMjggKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi9iYi91aS9rbm90dHkucHkgYi9saWIvYmIv
dWkva25vdHR5LnB5CmluZGV4IDE1MDI1ZThkZC4uMzQzMDQ1ODgxIDEwMDY0NAotLS0gYS9saWIv
YmIvdWkva25vdHR5LnB5CisrKyBiL2xpYi9iYi91aS9rbm90dHkucHkKQEAgLTM3LDYgKzM3LDIx
IEBAIGZlYXR1cmVTZXQgPSBbYmIuY29va2VyLkNvb2tlckZlYXR1cmVzLlNFTkRfU0FOSVRZRVZF
TlRTLCBiYi5jb29rZXIuQ29va2VyRmVhdHVyCiBsb2dnZXIgPSBsb2dnaW5nLmdldExvZ2dlcigi
Qml0QmFrZSIpCiBpbnRlcmFjdGl2ZSA9IHN5cy5zdGRvdXQuaXNhdHR5KCkKIAorZGVmIGJiX2Vs
YXBzZWQoc2VjKToKKyAgICBocnMgPSBpbnQoc2VjIC8gMzYwMC4wKQorICAgIHNlYyAtPSBocnMg
KiAzNjAwCisgICAgbWluID0gaW50KHNlYyAvIDYwLjApCisgICAgc2VjIC09IG1pbiAqIDYwCisg
ICAgaWYgaHJzID4gMDoKKyAgICAgICAgcmV0dXJuICIlZGglZG0lZHMiICUgKGhycywgbWluLCBz
ZWMpCisgICAgZWxpZiBtaW4gPiAwOgorICAgICAgICByZXR1cm4gIiVkbSVkcyIgJSAobWluLCBz
ZWMpCisgICAgZWxzZToKKyAgICAgICAgcmV0dXJuICIlZHMiICUgKHNlYykKKworY2xhc3MgQkJU
aW1lcihwcm9ncmVzc2Jhci5UaW1lcik6CisgICAgZm9ybWF0X3RpbWUgPSBzdGF0aWNtZXRob2Qo
YmJfZWxhcHNlZCkKKwogY2xhc3MgQkJQcm9ncmVzcyhwcm9ncmVzc2Jhci5Qcm9ncmVzc0Jhcik6
CiAgICAgZGVmIF9faW5pdF9fKHNlbGYsIG1zZywgbWF4dmFsLCB3aWRnZXRzPU5vbmUsIGV4dHJh
cG9zPS0xLCByZXNpemVfaGFuZGxlcj1Ob25lKToKICAgICAgICAgc2VsZi5pZCA9IG1zZwpAQCAt
MjUwLDE2ICsyNjUsNyBAQCBjbGFzcyBUZXJtaW5hbEZpbHRlcihvYmplY3QpOgogICAgICAgICBz
ZWxmLl9mb290ZXJfbGluZXMgPSBOb25lCiAKICAgICBkZWYgZWxhcHNlZChzZWxmLCBzZWMpOgot
ICAgICAgICBocnMgPSBpbnQoc2VjIC8gMzYwMC4wKQotICAgICAgICBzZWMgLT0gaHJzICogMzYw
MAotICAgICAgICBtaW4gPSBpbnQoc2VjIC8gNjAuMCkKLSAgICAgICAgc2VjIC09IG1pbiAqIDYw
Ci0gICAgICAgIGlmIGhycyA+IDA6Ci0gICAgICAgICAgICByZXR1cm4gIiVkaCVkbSVkcyIgJSAo
aHJzLCBtaW4sIHNlYykKLSAgICAgICAgZWxpZiBtaW4gPiAwOgotICAgICAgICAgICAgcmV0dXJu
ICIlZG0lZHMiICUgKG1pbiwgc2VjKQotICAgICAgICBlbHNlOgotICAgICAgICAgICAgcmV0dXJu
ICIlZHMiICUgKHNlYykKKyAgICAgICAgcmV0dXJuIGJiX2VsYXBzZWQoc2VjKQogCiAgICAgZGVm
IGtlZXBBbGl2ZShzZWxmLCB0KToKICAgICAgICAgaWYgbm90IHNlbGYuY3V1OgpAQCAtMzU0LDcg
KzM2MCw3IEBAIGNsYXNzIFRlcm1pbmFsRmlsdGVyKG9iamVjdCk6CiAgICAgICAgICAgICAgICAg
bXNnID0gIkN1cnJlbnRseSAlMnMgcnVubmluZyB0YXNrcyAoJXMpIiAlIChsZW4oYWN0aXZldGFz
a3MpLCBjdXJfdGFza3MpCiAgICAgICAgICAgICBtYXh0YXNrID0gc2VsZi5oZWxwZXIudGFza251
bWJlcl90b3RhbAogICAgICAgICAgICAgaWYgbm90IHNlbGYubWFpbl9wcm9ncmVzcyBvciBzZWxm
Lm1haW5fcHJvZ3Jlc3MubWF4dmFsICE9IG1heHRhc2s6Ci0gICAgICAgICAgICAgICAgd2lkZ2V0
cyA9IFsnICcsIHByb2dyZXNzYmFyLlBlcmNlbnRhZ2UoKSwgJyAnLCBwcm9ncmVzc2Jhci5CYXIo
KV0KKyAgICAgICAgICAgICAgICB3aWRnZXRzID0gWycgJywgcHJvZ3Jlc3NiYXIuUGVyY2VudGFn
ZSgpLCAnICcsIHByb2dyZXNzYmFyLkJhcigpLCAnICcsIEJCVGltZXIoZm9ybWF0PSdFbGFwc2Vk
OiAlcycpXQogICAgICAgICAgICAgICAgIHNlbGYubWFpbl9wcm9ncmVzcyA9IEJCUHJvZ3Jlc3Mo
IlJ1bm5pbmcgdGFza3MiLCBtYXh0YXNrLCB3aWRnZXRzPXdpZGdldHMsIHJlc2l6ZV9oYW5kbGVy
PXNlbGYuc2lnd2luY2hfaGFuZGxlKQogICAgICAgICAgICAgICAgIHNlbGYubWFpbl9wcm9ncmVz
cy5mZCA9IHNlbGYuX2Zvb3Rlcl9idWYKICAgICAgICAgICAgICAgICBzZWxmLm1haW5fcHJvZ3Jl
c3Muc3RhcnQoRmFsc2UpCi0tIAoyLjUzLjAKCg==

--D8qpGTQGdahWdWZKuozP--

