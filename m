Received: from mga12.intel.com ([143.182.124.36] helo=azsmga102.ch.intel.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TxxWJ-0004oq-GN
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Jan 2013 11:25:44 +0100
Received: from mail-ob0-f200.google.com ([209.85.214.200])
	by mga14.intel.com with ESMTP/TLS/RC4-SHA; 23 Jan 2013 02:08:50 -0800
Received: by mail-ob0-f200.google.com with SMTP id wd20so40525528obb.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jan 2013 02:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-received:x-received:mime-version:from:date:message-id:subject:to
	:content-type:x-gm-message-state;
	bh=UmyeKQmlVext5cyI/ygY7Ty2jL9cKXl3kwU3mNCfQHo=;
	b=B0UWDPTZbVPNcHJbFdf9FDCpQtmU8CvTZejGJTMClDcgLmwGRWb+ZekXtl7RUV4oEC
	Pr5gAEm9DWMTkyQxNXQ6iNH2R9tb6MGAg2/QMe7Rop1taW3kzMnCr3uGgXzfob1f1rT8
	XzCw0pmjpbhxj1Fb3/J/nbmK4WlJkbRAsRCjbefRGydaTOBeNa+y5aAWF7auCXYh0fFM
	NyUJplATMiwniJerHe8HtRNCTipJ2lp20G1CM5VOvHsry6FxMBZjzkeBHKM67RYzzfIn
	/4Ig7X2QYu4UEb1yZIqPBdTfeesMJLfGwqwLo82RJN1TI13QTaVJZGa7q1XG5OOtP7XY
	kk3A==
X-Received: by 10.60.22.164 with SMTP id e4mr512739oef.87.1358935729151;
	Wed, 23 Jan 2013 02:08:49 -0800 (PST)
X-Received: by 10.60.22.164 with SMTP id e4mr512733oef.87.1358935729031; Wed,
	23 Jan 2013 02:08:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.5.4 with HTTP; Wed, 23 Jan 2013 02:08:28 -0800 (PST)
From: "Marinescu, Bogdan A" <bogdan.a.marinescu@intel.com>
Date: Wed, 23 Jan 2013 12:08:28 +0200
Message-ID: <CAMZjud1sM6e2Rd2tWsBjt_XJ7N9J6AZo5OJg+R6q47AXwdg_3A@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Gm-Message-State: ALoCoQnm6tj9fvetDWE1TC7sy4cEqDMDdxCiqDCWDoVFPFmcHpsiY/8uxas79Sh2P8yPZ1xEUDtBKcEh5JQhfBX7HGJ3nM9ga/Nn4+rfMHMYcsdCUFsDiwSHn6ihOx8a6Hu0hR64mBtdL1iscDB90Xevj0u2oy/b5+M/xw1AtVopy383IBKmpC56S/Fw3Nep/NI+vYNR/LLg
Subject: RFC: bugfix for 3575
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 Jan 2013 10:25:45 -0000
Content-Type: multipart/alternative; boundary=e89a8fb203ee66ca7704d3f1e151

--e89a8fb203ee66ca7704d3f1e151
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Please review my fix of bug 3575 (Ensure windows hob client communication
with bitbake backend via xmlrpc). I'd like to get feedback before uploading
the patches. I've pushed my fix on poky-contrib:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=bogdanm/b3575

Currently, the fix allows bitbake and hob to run on different machines and
"talk" to each other via XMLRPC (no windows version yet, but it can be
tested in Linux). Hopefully the commit messages will tell the rest of the
story.

Thanks,
Bogdan

--e89a8fb203ee66ca7704d3f1e151
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>Please review my fix of bug 3575 (Ensure windows hob=
 client communication with bitbake backend via xmlrpc). I&#39;d like to get=
 feedback before uploading the patches. I&#39;ve pushed my fix on poky-cont=
rib:</div>

<div><br></div><div><a href=3D"http://git.yoctoproject.org/cgit/cgit.cgi/po=
ky-contrib/log/?h=3Dbogdanm/b3575">http://git.yoctoproject.org/cgit/cgit.cg=
i/poky-contrib/log/?h=3Dbogdanm/b3575</a></div><div><br></div><div>Currentl=
y, the fix allows bitbake and hob to run on different machines and &quot;ta=
lk&quot; to each other via XMLRPC (no windows version yet, but it can be te=
sted in Linux). Hopefully the commit messages will tell the rest of the sto=
ry.</div>

<div><br></div><div>Thanks,</div><div>Bogdan</div><div><br></div>

--e89a8fb203ee66ca7704d3f1e151--
