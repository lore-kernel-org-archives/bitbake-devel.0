Return-Path: <zzs213@126.com>
Received: from m15-112.126.com (m15-112.126.com [220.181.15.112])
	by mail.openembedded.org (Postfix) with ESMTP id 4836F605BA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Aug 2016 05:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=SQyPB
	NV/+y79RKVornhip4shLlsz8TCrSaYi77mmxzo=; b=WNrFhtOHakeOS2czBgv9+
	PVGkPZnWB/so1z/qhoPMLByY9/LP1swZoAOQRHIaTQq37Q5VYzVbCHkl5vhwzbAd
	9NxLjCYXC0b7n1HwMkFqaJq50tm2XGOYa0vEEcFe0GvqhlJE7OagBNurUyoELB41
	EU5HAHUYy2SPWMOui7GpVM=
Received: from [192.168.0.12] (unknown [171.212.170.252])
	by smtp2 (Coremail) with SMTP id DMmowAD3pGEUz8NXq+ZSEA--.46659S2;
	Mon, 29 Aug 2016 13:58:46 +0800 (CST)
References: <1472189699-6646-1-git-send-email-zzs213@126.com>
	<CAMKF1soRMSf9EvC5RMuVuJbyA4dRC=n+B9nSjCXovD_F_zvTwQ@mail.gmail.com>
	<77d61119-5b4f-d897-fa94-4490098219bc@126.com>
	<CABcZANkpWPy6fxnyr4SQL1Zmcv-ckn6yW2Y=4mgMhm59W_Fegg@mail.gmail.com>
From: =?UTF-8?B?5byg5b+g5bGx?= <zzs213@126.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <b9692b20-b61f-cfb0-8c15-bc2ff763172f@126.com>
Date: Mon, 29 Aug 2016 13:58:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CABcZANkpWPy6fxnyr4SQL1Zmcv-ckn6yW2Y=4mgMhm59W_Fegg@mail.gmail.com>
X-CM-TRANSID: DMmowAD3pGEUz8NXq+ZSEA--.46659S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq1EEUUUUU
X-Originating-IP: [171.212.170.252]
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiJBbUGVWnkmcJFgAAsn
Subject: Re: [PATCH] enable override for suffix just include digit and dot
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
X-List-Received-Date: Mon, 29 Aug 2016 05:58:52 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

>
> OVERRIDES .= ":pv-${@'${PV}'.replace('.', '_')}"
> FOO_pv-1_1_7 = "bar"
>

Now I test my project fully, Found can't use ${PV} to generate OVERRIDES.

Because of BBVERSIONS, When generage OVERRIDES, the PV not setted 
according PREFFERED_VERSION_xxx. It use the setting in bitbake.conf 
which default to `1.0`

So maybe this worked:

OVERRIDES .= ":pv-${PREFERRED_VERSION_${PN}}"
FOO_pv-1_1_7 = "bar"



