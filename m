Return-Path: <paul@betafive.co.uk>
X-Greylist: delayed 428 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 15 Nov 2019 13:06:25 UTC
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com
	[64.147.123.21])
	by mail.openembedded.org (Postfix) with ESMTP id 923967DF61
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 13:06:25 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1A77164E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 07:59:17 -0500 (EST)
Received: from imap2 ([10.202.2.52])
	by compute1.internal (MEProxy); Fri, 15 Nov 2019 07:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=betafive.co.uk;
	h=mime-version:message-id:date:from:to:subject:content-type; s=
	fm3; bh=wwpUEHlwfijNiV/uwgzUrsgSl4BZXGTX0i4wdw107os=; b=pbpRDT9d
	Zx/YgS2MrC36ZLgTECfVuOco/L7LFBU2gnJGi5WtJ3SonrAhQNGrKHwKP/YO+plj
	Lp/vS0f0J+aqB7RRKoP6jiYZqZx6wO1iU4hNgoWj0lQ05faTqTFTUJ5C6dfozp9N
	shdTSdD9n/zTrQRcFBYYy3Q7ts9pjjujljMyxgm5sj+TmIrBBAgVswpFDDFx5qWG
	GDy6nnKZEaiuIWVoeCaEh54yBxExcr7bPwuOaZi49ZCluQwj2PyYCFCCyVdcca6x
	vC0VdXzV+mOON3vgCZ2D/EaKfHUbS2JzBgowI1zh+63G/BYruGF8/dGJC1kL8XHV
	UuuEL7WdM3Au/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:date:from:message-id
	:mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; bh=wwpUEHlwfijNiV/uwgzUrsgSl4BZX
	GTX0i4wdw107os=; b=uYM20FtcRRWT8NqDOV0O4AHvS+qAtZ3C5TOaZvmfzfcaS
	TAq3GGesXzRTgArXEFj65i7IH6cT2fbYYEZmQVWsJUgOSNdIWWif9U2iGxsSk0m6
	ih8pXzkV7PJZQga22XVoagu4ssTh4MKcjDUqgTGMraliXcuUR3Lyz8+CtpaqxHF0
	cp1LR6kcRaxia5BGVsX67EkMOp0mmBVd/SS8zRB3/splMvKk4oAefuj9FNA8sa7f
	lOUHJicOMR5h+BbvIlv+QOerp5CunD6+A97ejUiIgxu6G7QO1Seq1eyCO/peQWdB
	2ALHzgkernZe47l+HVLO1lZEurtvDaJ1Ae05fFlkw==
X-ME-Sender: <xms:JKHOXTcYGqhuefwilBndQW_Jwvd3QdXpMds_WQu36lrtPqDmfcIh1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedggeejucetufdoteggodetrfdotf
	fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
	uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
	erredtnecuhfhrohhmpedfrfgruhhluceurghrkhgvrhdfuceophgruhhlsegsvghtrghf
	ihhvvgdrtghordhukheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhessggvth
	grfhhivhgvrdgtohdruhhknecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:JKHOXSgpf-0WG8-pumOMkbam4at8xvvBcFR9JKWG2msCxDr_usD1-w>
	<xmx:JKHOXTxFdGU-LeQtLpNOfz0M8oCOaSVa5YaTQxF2eH9Dfn6znuAk8w>
	<xmx:JKHOXWOBNRN9xx7_7MDGYS2ot8nSlPm9oyvlpn9yZzqCBw0o7ZRHLQ>
	<xmx:JKHOXRXm4Q5AmO1GtFBmCZlcd4SUHn6qejcARdC-k8UdNDJ8jjT-sg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3F98AE00A3; Fri, 15 Nov 2019 07:59:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-562-gfd0633a-fmstable-20191114v1
Mime-Version: 1.0
Message-Id: <5d3e68e3-5c06-43f5-8a28-b19834b7b7c5@www.fastmail.com>
Date: Fri, 15 Nov 2019 12:58:56 +0000
From: "Paul Barker" <paul@betafive.co.uk>
To: bitbake-devel@lists.openembedded.org
Subject: Warnings when starting bitbake with Python 3.8.0
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
X-List-Received-Date: Fri, 15 Nov 2019 13:06:25 -0000
Content-Type: text/plain

I'm using Arch on one of my dev machines and recent upgrades have brought in Python 3.8.0.

When running bitbake (latest master, 33197db8abf82be240d7c1c5c9d2484a08a90849) I'm seeing the following warnings. This only happens on the first invocation as __pycache__ is used after this.

    /.../bitbake/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: "is" with a literal. Did you mean "=="?
      if command is 'mkview':
    /.../bitbake/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: "is" with a literal. Did you mean "=="?
      elif command is 'rmview':
    /.../bitbake/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: "is" with a literal. Did you mean "=="?
      elif command is 'setcs':

I've never used the clearcase fetcher and have no way of testing this myself so I don't want to dive into it. May be worth someone who is using this taking a look at it though.

Thanks,

-- 
Paul Barker

