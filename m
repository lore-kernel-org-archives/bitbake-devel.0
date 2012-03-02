Received: from mail-qw0-f54.google.com ([209.85.216.54])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1S3UcR-0003sx-FO
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 16:42:07 +0100
Received: by qao25 with SMTP id 25so293304qao.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Mar 2012 07:33:36 -0800 (PST)
Received-SPF: pass (google.com: domain of kergoth@gmail.com designates
	10.224.181.66 as permitted sender) client-ip=10.224.181.66; 
Authentication-Results: mr.google.com;
	spf=pass (google.com: domain of kergoth@gmail.com
	designates 10.224.181.66 as permitted sender)
	smtp.mail=kergoth@gmail.com;
	dkim=pass header.i=kergoth@gmail.com
Received: from mr.google.com ([10.224.181.66])
	by 10.224.181.66 with SMTP id bx2mr6839907qab.68.1330702416084
	(num_hops = 1); Fri, 02 Mar 2012 07:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=CNzfWPhJC6Jx7aWtirgdj/usdnLFNMEhkK2yrYHRLc8=;
	b=CGH2fcWG542pWk0wGwGLj1iYF1HU2nbX2gLygKY2Q5NDDPTUsk2bZkaMVlbJ24ZXPr
	KiaS7ryiWAXtVPZKs8uXpRt97u6v7EZ25nHJGuaZluii2GqfvUC8TNwJlCnrLXJqYT1z
	0CxYjGG2XaXy2H++xW7XLxH8ADa7GWaeMr+nAErUnmDUSOew/3vW2bE897GVvZFYnmfW
	yhtcO9NNizEHGH/AfDgjwva2wA5R1r0LAxgSSCkeivEdjhIdpQ0InoeKTqh4tfLB2GeG
	dFPyZR0b8SXOvHvbrf2HZ5J6/2kHjP3SiZ7kO+I5cmkPvmx5HkE/YmN2RpZrThH9ODuf
	oWrw==
Received: by 10.224.181.66 with SMTP id bx2mr5731998qab.68.1330702415998; Fri,
	02 Mar 2012 07:33:35 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.224.145 with HTTP; Fri, 2 Mar 2012 07:33:13 -0800 (PST)
In-Reply-To: <bbac4fa41e627a8673202459461c10e0c1426b61.1330674604.git.kai.kang@windriver.com>
References: <cover.1330674604.git.kai.kang@windriver.com>
	<bbac4fa41e627a8673202459461c10e0c1426b61.1330674604.git.kai.kang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 2 Mar 2012 08:33:13 -0700
X-Google-Sender-Auth: u4ohqw3IspPERTmf0KMJFC0tVhA
Message-ID: <CABcZANmgbf_fDAxsqOkzzNX2t81u2tkeGsgibgo3nDyQzA1vng@mail.gmail.com>
To: Kang Kai <kai.kang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: enable cleanup of WORKDIR
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
X-List-Received-Date: Fri, 02 Mar 2012 15:42:07 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 2, 2012 at 12:54 AM, Kang Kai <kai.kang@windriver.com> wrote:
> [Yocto 1561]
> Add a command line option for bitbake to enable cleanup of WORKDIR.
> It checks every package build directories under WORKDIR then parse
> the directory name to get package name and version. If the version
> is not the package prefer version then delete the directory.
>
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
> =C2=A0bitbake/bin/bitbake =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +++
> =C2=A0bitbake/lib/bb/command.py | =C2=A0 =C2=A05 +++
> =C2=A0bitbake/lib/bb/cooker.py =C2=A0| =C2=A0 63 ++++++++++++++++++++++++=
+++++++++++++++++++++
> =C2=A03 files changed, 72 insertions(+), 0 deletions(-)

This is wrong on multiple levels. bitbake (other than some hacky stuff
in the fetcher that needs to die) has *zero* knowledge of the use of
WORKDIR today, that's entirely metadata implementation.
--=20
Christopher Larson


