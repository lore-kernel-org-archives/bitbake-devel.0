Return-Path: <armccurdy@gmail.com>
Received: from mail-vk0-f47.google.com (mail-vk0-f47.google.com
	[209.85.213.47])
	by mail.openembedded.org (Postfix) with ESMTP id 057E377029
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jun 2018 21:53:43 +0000 (UTC)
Received: by mail-vk0-f47.google.com with SMTP id y137-v6so4758256vkd.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Jun 2018 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=FJwD2IvALpqsfvSLIIRqiivGhmePTE11UhcIC4CIW/o=;
	b=TrHQn+rgTRPG7DIM1XIICoJmgpLiXdRsNoM0WCBDeZexomD+Kq2vMNyjL9gUKYtSAz
	PYn6h9KKpXKdK0YtiXDmulq84Chd6R548QurabmpaKE8NGo7xqDzJ4wRN1Kz1Wn6soym
	jkUE+UyepT+eEh3MiiAscR2ZM8KILODVPiTKbK6pmdBm7ueKXBwQWOvUVTG3CnM0weJ4
	XIfL0u/mtPbyQDe+5i8SIJ6icS8iedDtFiSWvdFfFMkTwS0inbQGUD4OOWMJ8fRAwKgU
	6oLG27LQytRYNEsSsFqzeULGyn6ORs2dIlKAqR1Sl6OHRu/iHCaj7PibdZP2aCxd79vT
	s+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=FJwD2IvALpqsfvSLIIRqiivGhmePTE11UhcIC4CIW/o=;
	b=shJSmZjSK7d9mpvToV2tIup3xvzArHbba31iirecHb+yGy8cbeyLJAWYub4GAlHuTx
	9e1bitTyZI4CZbcg58WLwL03fFZxtZHyyWWp98ffvxZZpsZ3I4yiWigxa/OIeIpYRtut
	4+2OYrq/azloLzZKvDxDjwUqLPjPJA4P+MU5CtfTXfkWcy7MlQw1rRnX014vGxvtO2G4
	pb2rZ93dfoPi1i8XvgWXMslF5tS345NCu4ziiwdpM4Z0j8J6Oy2HMSZ9aTTAaUv0VCa1
	u6Wmq7r/hN+C4yDar2eHEFPB4UEl759eQ2wUqIB7GXvK1hOvK4HRCdctBP44WyOMu4mw
	W4zA==
X-Gm-Message-State: APt69E2cmRdL/4zOA1+OBTuqxd8irdVQMhxU7XrO1rXN/xsbg5p7uVp4
	8IvuM2pf07/vI9L/WKD/34bPal+gEGAxUZg/aH0AXA==
X-Google-Smtp-Source: ADUXVKI9Nd0v90oLucRQP4mAXQQnki183jqPY/LzgfzONXfRV9f/K23FKNi4ht/wwYQbimIt10Wc+xDCUj/8chujnuQ=
X-Received: by 2002:a1f:9615:: with SMTP id
	y21-v6mr3096455vkd.154.1528322024397; 
	Wed, 06 Jun 2018 14:53:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:28a:0:0:0:0:0 with HTTP;
	Wed, 6 Jun 2018 14:53:43 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
Date: Wed, 6 Jun 2018 14:53:43 -0700
Message-ID: <CAJ86T=U2s_uFMpc4ZwicFaixqfHo5ABMyKbbrU4XKtHV6-gwMQ@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: expand after getVar
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
X-List-Received-Date: Wed, 06 Jun 2018 21:53:44 -0000
Content-Type: text/plain; charset="UTF-8"

Is the following expression from trusted_network():

  d.expand(d.getVar('PN', False))

completely equivalent to:

  d.getVar('PN")

or is there something subtle going on?

