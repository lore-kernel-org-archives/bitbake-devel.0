Return-Path: <mleonhardt@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722FECDE027
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 17:59:08 +0000 (UTC)
Subject: Re: [PATCH] bitbake: wget: fix netrc with pseudo
To: bitbake-devel@lists.openembedded.org
From: "Manuel Leonhardt" <mleonhardt@arri.de>
X-Originating-Location: Munich, Bavaria, DE (217.111.95.84)
X-Originating-Platform: Mac Safari 18
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Thu, 26 Sep 2024 10:59:06 -0700
References: <fafd955b61a56e8f9ecc1565da11496cd54c0475.camel@linuxfoundation.org>
In-Reply-To: <fafd955b61a56e8f9ecc1565da11496cd54c0475.camel@linuxfoundation.org>
Message-ID: <20211.1727373546044668123@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="OfrP2Amj8wJthyXu3kY9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Sep 2024 17:59:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16608

--OfrP2Amj8wJthyXu3kY9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

We encounter the same issue, interestingly only with the packagegroup-cross=
-canadian-qemux86-64-1.0-r0 package. For our case a few potential solutions=
 come to my mind:

* Excluding packagegroup-cross-canadian from sstate caching. Since this is =
only the packagegroup, it won't significantly impact performance. However, =
this approach merely circumvents the symptom without addressing the underly=
ing cause.
* Subclassing the netrc class and patching the _security_check method to be=
come a no-op. This solution is compatible only with Python 3.11 and later v=
ersions, as the relevant code wasn't refactored into a dedicated method in =
earlier releases. See https://github.com/python/cpython/issues/72992
* Refactoring the checkstatus method to parse the .netrc file in a subproce=
ss without fakeroot. I guess this would have a performance impact though. W=
hile I haven't tested this yet, here's a rough sketch (non-working example)=
:

cmd =3D "export PSEUDO_DISABLED=3D1; python3 -c 'import json,netrc,sys; pri=
nt(json.dumps(netrc.netrc().authenticators(sys.argv[4]))' " + hostname
(output, errors) =3D bb.process.run(cmd, log=3Dlog, shell=3DTrue, stderr=3D=
subprocess.PIPE, cwd=3Dworkdir)
auth_data =3D json.loads(output)

--OfrP2Amj8wJthyXu3kY9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>We encounter the same issue, interestingly only with the packagegroup-cr=
oss-canadian-qemux86-64-1.0-r0 package. For our case a few potential soluti=
ons come to my mind:</p>
<ul>
<li>Excluding packagegroup-cross-canadian from sstate caching. Since this i=
s only the packagegroup, it won't significantly impact performance. However=
, this approach merely circumvents the symptom without addressing the under=
lying cause.</li>
<li>Subclassing the netrc class and patching the _security_check method to =
become a no-op. This solution is compatible only with Python 3.11 and later=
 versions, as the relevant code wasn't refactored into a dedicated method i=
n earlier releases. See <a href=3D"https://github.com/python/cpython/issues=
/72992">https://github.com/python/cpython/issues/72992</a></li>
<li>Refactoring the checkstatus method to parse the .netrc file in a subpro=
cess without fakeroot. I guess this would have a performance impact though.=
 While I haven't tested this yet, here's a rough sketch (non-working exampl=
e):</li>
</ul>
<pre>cmd =3D "export PSEUDO_DISABLED=3D1; python3 -c 'import json,netrc,sys=
; print(json.dumps(netrc.netrc().authenticators(sys.argv[4]))' " + hostname
(output, errors) =3D bb.process.run(cmd, log=3Dlog, shell=3DTrue, stderr=3D=
subprocess.PIPE, cwd=3Dworkdir)
auth_data =3D json.loads(output)
</pre>

--OfrP2Amj8wJthyXu3kY9--

