Return-Path: <pinganddu90@gmail.com>
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com
	[209.85.161.180])
	by mail.openembedded.org (Postfix) with ESMTP id CB7AC776EB
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Mar 2017 13:24:32 +0000 (UTC)
Received: by mail-yw0-f180.google.com with SMTP id v198so46224510ywc.2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Mar 2017 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=dkkkgPZlnfPaDIl8fNKPSv0RtMIFEMYAjik9vF60pko=;
	b=NJ3DBrQPhJu8q2L3ziMKOviCuVBHSNEKLbRgFocd+VA167Y/F4yh1IugwKvR20pimh
	wq1WfaF23VArmqe3gDZMiC2OY1oXXsV+Cb6FmPX9SD6oKRDRRwz6+OEEDhyC15+UOWmm
	dkYnmDfV/vVv2awQ1FAqppMCjhKsmnE43uaJTd4CNmIQpH7edPJtj3NAeCSkW6DBVQ+x
	tgDR9gdBeSUbPz2PPWWuVAjDR4Dip6aP959JmYjmCR135Xsk5NbZ50MOlHDrgoaHtuyC
	c05i3AQAPP01Jpc6cG5Mp8HPhFGKqZDwyJd54e7l4vnFq2/XGeEjjHfrLzrHuxRw1jp6
	74nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=dkkkgPZlnfPaDIl8fNKPSv0RtMIFEMYAjik9vF60pko=;
	b=hzvM5FDcbub2+dAheso4JZdQ7BteEYqicxyRq7Jlf1oDThXzlhqUj+Um2oyuGAPwMz
	hHj1L13fu4lE1luyprvLdxzdfM52OaIu3291sQ7/kpx8e2MaWYbYuyU4xkkEKUR5uP2s
	PDyT0zCJm3jhJrtx0APO/SY4TM2ikjU9Nn0TENBfK3ZvkEnj7a7OXd3Lw74fMI1A4VoG
	u2GvFXgLwSy4czhOjkoWzfEJNeyIQQhvLsCqwGBLOfZRnjFUPMxSWrTuaow5dfHV9/JM
	69OV6/AOaysnGSLfnoGQfyCxd71F1hI5MTSz8K/jG63BlC0NcHa4AA2QMYO9+6rId01D
	scOg==
X-Gm-Message-State: AMke39lr8xAP2O1dELHGsv+WPWGsrZd39gMqOGQWiLH7F9ln530Myz3DdoLmgruDEUK3nD1VLynUhElLcTlAjg==
X-Received: by 10.129.89.193 with SMTP id n184mr14159834ywb.280.1489325073309; 
	Sun, 12 Mar 2017 06:24:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.12.202 with HTTP; Sun, 12 Mar 2017 06:24:32 -0700 (PDT)
From: kk <pinganddu90@gmail.com>
Date: Sun, 12 Mar 2017 21:24:32 +0800
Message-ID: <CAKHP1dvO0V3+d5jbAXx6-3t+TxnjZzh210voMqrbxZKGmrai1A@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: What does the "fn" represent for in "<fn>:<taskname>"?
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 12 Mar 2017 13:24:33 -0000
Content-Type: multipart/alternative; boundary=001a1141c2f0f326ae054a8883a1

--001a1141c2f0f326ae054a8883a1
Content-Type: text/plain; charset=UTF-8

In commit:
    2c88afb60da54e58f555411a7bd7b006b0c29306
uses "<fn>:<taskname>" as the ID for tasks rather than a number, I know
taskname represent for, but the <fn> I don't understand, does it means file
name or function name?

Thanks

--001a1141c2f0f326ae054a8883a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>In commit:<br>=C2=A0=C2=A0=C2=A0 2c88afb60da54e5=
8f555411a7bd7b006b0c29306<br></div>uses &quot;&lt;fn&gt;:&lt;taskname&gt;&q=
uot; as the ID for tasks rather than a number, I know taskname represent fo=
r, but the &lt;fn&gt; I don&#39;t understand, does it means file name or fu=
nction name?<br><br></div>Thanks<br></div>

--001a1141c2f0f326ae054a8883a1--
