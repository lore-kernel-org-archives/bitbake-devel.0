Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.66261.1629362183415663248
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Aug 2021 01:36:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sigma-chemnitz.de header.s=v2012061000 header.b=dB2Tyk1l;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-3.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17J8aJ9n499027
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 19 Aug 2021 10:36:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2012061000; t=1629362179;
	bh=XM8m25jKFl6HksI8bqiuKof5r9QJJTAi3ncFKqgAqNo=; l=497;
	h=From:To:Cc:Subject:References:Date:In-Reply-To;
	b=dB2Tyk1lcdDrlNNHZ78oEzIRV8F+O8CCwEeBUQQ5avXFdjCDYhGEXOYIygxMu29qg
	 azWErsA13aGdd2UOaevt8xuIUcn9tm9b3WV1cwVEiPI9uL6G2DDw/OoJdAQab04ojP
	 n+3r47ujvn2rTIt/tOXyowuj+sGkHbyU+vNCI5Yk=
Received: from reddoxx.intern.sigma-chemnitz.de ([192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTP id 17J8aD0r673296;
	Thu, 19 Aug 2021 10:36:13 +0200
Received: from mail-msa-2.intern.sigma-chemnitz.de ( [192.168.12.72]) by reddoxx.intern.sigma-chemnitz.de
	(Reddoxx engine) with SMTP id 83C18A06804; Thu, 19 Aug 2021 10:36:11 +0200
Received: from ensc-virt.intern.sigma-chemnitz.de (ensc-virt.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.16.1/8.16.1) with ESMTPS id 17J8aBDH599701
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 19 Aug 2021 10:36:11 +0200
Received: from ensc by ensc-virt.intern.sigma-chemnitz.de with local (Exim 4.94.2)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1mGdX1-005ru4-3Y; Thu, 19 Aug 2021 10:36:11 +0200
From: "Enrico Scholz" <enrico.scholz@sigma-chemnitz.de>
To: "Chris Laplante via lists.openembedded.org"
 <chris.laplante=agilent.com@lists.openembedded.org>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>,
        chris.laplante@agilent.com
Subject: Re: [bitbake-devel] Trouble capturing layer revision as variable in recipe
References: <DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
Date: Thu, 19 Aug 2021 10:36:11 +0200
In-Reply-To: <DM8PR12MB5430C5689FA1BE41556758938BFF9@DM8PR12MB5430.namprd12.prod.outlook.com>
	(Chris Laplante via lists openembedded org's message of "Wed, 18 Aug
	2021 19:21:05 +0000")
Message-ID: <lyv941g7b8.fsf@ensc-virt.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain

"Chris Laplante via lists.openembedded.org"
<chris.laplante=agilent.com@lists.openembedded.org> writes:

> OUR_LAYER_PATH := "${@get_layer_path(d, "meta-our-layer")}"

fwiw, we capture this location by 'LAYERDIR_<layer> := "${LAYERDIR}"'
within our layer.conf[1].

It would be nice, when bitbake adds such a variable automatically...


Enrico

Footnotes:
[1]  https://github.com/sigma-embedded/meta-de.sigma-chemnitz/blob/5c4f79148e72d5c009be322e5cc32256ffb58bb4/conf/layer.conf#L17
