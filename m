Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80811C54E71
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 14:36:42 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.413.1747838199997574259
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 May 2025 07:36:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=acihxCQD;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB8F943952;
	Wed, 21 May 2025 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747838198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btGi37GdK9rL4VMFTrHo2XhQ3xXSBsgrajQetIVyGv4=;
	b=acihxCQDiY9SFUyBnQYshDSFnTD3jfgTh3Q2PxORJ8BllXzn0pZPd+vBRGDOwah4leYCQx
	kk3cchfMwS43AVb8TZYx4DBYtivSeVUEMFPG8VzyBTIxvzeg3A+OiCIODjbSHHi2AJYcQa
	2TVGxPv/0D05CVLLk2fdb6AZk8WLFX6CqFxnjlqCxM8d/qzlEDlS4vfgNXr80SZRJ9QSl+
	ukp/oZWYS5GPoTKOvmWRs0cEoZaMXDtoo3AJ7yqKpWt74WmP6fJ/1Qb+vFu3Tw6rnDz3Xc
	jFGWWyAmvnpmCqP9BKqN1kluNwzwR2IdFXQkJDOeVixnVdSxauksoqNGCLF8Ng==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 May 2025 16:36:36 +0200
Message-Id: <DA1WXIN1ZNNJ.8GK9QFPZ4HKI@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2: Ensure a valid symlink in
 `PREMIRRORS` case when using shallow cloning
Cc: <docs@lists.yoctoproject.org>, <richard.purdie@linuxfoundation.org>,
 <liezhi.yang@windriver.com>, <niqingliang2003@gmail.com>,
 <alex.kanavin@gmail.com>, <quentin.schulz@cherry.de>,
 <simon.sudler@siemens.com>, <jan.kiszka@siemens.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <stefan-koch@siemens.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250521091153.2445853-1-stefan-koch@siemens.com>
 <20250521091153.2445853-2-stefan-koch@siemens.com>
In-Reply-To: <20250521091153.2445853-2-stefan-koch@siemens.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeegucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudehgefgteegheegjeehhffhgeelkeehgfelfeeukeetvdekiedttdevgeefudeunecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghdphihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepshhtvghfrghnqdhkohgthhesshhivghmvghnshdrtghom
 hdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopeguohgtsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhivgiihhhirdihrghnghesfihinhgurhhivhgvrhdrtghomhdprhgtphhtthhopehnihhqihhnghhlihgrnhhgvddttdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgigrdhkrghnrghvihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhhuvghnthhinhdrshgthhhulhiisegthhgvrhhrhidruggv
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 May 2025 14:36:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17626

On Wed May 21, 2025 at 11:11 AM CEST, Stefan via lists.openembedded.org Koc=
h wrote:
> - Since `ud.path` contains in that case the `PREMIRRORS` prefix path,
>   this change ensures that a correct symlink is set up.
>
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---

Hi Stefan,

Thanks for your patch.

It looks like these modifications will trigger an exception in some
cases:

NOTE: Fetching uninative binary shim http://downloads.yoctoproject.org/rele=
ases/uninative/4.7/x86_64-nativesdk-libc-4.7.tar.xz;sha256sum=3D5800d4e9a12=
9d1be09cf548918d25f74e91a7c1193ae5239d5b0c9246c486d2c (will check PREMIRROR=
S first)
ERROR: Execution of event handler 'uninative_event_fetchloader' failed
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/build-appliance/build/meta/classes-glob=
al/uninative.bbclass", line 80, in uninative_event_fetchloader
    fetcher.download()
  File "/srv/pokybuild/yocto-worker/build-appliance/build/bitbake/lib/bb/fe=
tch2/__init__.py", line 1875, in download
    done =3D m.try_mirrors(self, ud, self.d, mirrors)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/build-appliance/build/bitbake/lib/bb/fe=
tch2/__init__.py", line 1672, in try_mirrors
    return bool(try_mirrors(fetch, d, urldata, mirrors, check))
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/build-appliance/build/bitbake/lib/bb/fe=
tch2/__init__.py", line 1192, in try_mirrors
    ret =3D try_mirror_url(fetch, origud, uds[index], ld, check)
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/build-appliance/build/bitbake/lib/bb/fe=
tch2/__init__.py", line 1124, in try_mirror_url
    if ud.shallow and not os.path.exists(origud.fullshallow):
       ^^^^^^^^^^
AttributeError: 'FetchData' object has no attribute 'shallow'

https://autobuilder.yoctoproject.org/valkyrie/#/builders/78/builds/1698

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


