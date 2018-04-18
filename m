Return-Path: <raj.khem@gmail.com>
Received: from mail-pg0-f53.google.com (mail-pg0-f53.google.com [74.125.83.53])
	by mail.openembedded.org (Postfix) with ESMTP id 56B396E5CB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Apr 2018 20:02:29 +0000 (UTC)
Received: by mail-pg0-f53.google.com with SMTP id t12so1353010pgp.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Apr 2018 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Y8vYdZLL8dFsRmtPz5y/3UuzOFStPEHLUEHpl22lwto=;
	b=EdJXQCYSjz0C2rn8wnYsUtovt6ZeXmCq87fYAKlBcHXs7QfLbvLuSNYoH8bPsXhyne
	eaIedF3jMFVWsOSm9MzJ+qN8JMYyiH65CGFHH/llJMOpmZkpMS6EFJnTDWF6V34PQOLI
	5kp5r5UyiNJ+PbjC830kraRU0ozuAFQA/lNwkxBuh7rtiMHkLMEyE34YP5+aBGuL+Nka
	ctY7Zu7y2RSHWwUooQVrVl75kH7RLYs0muAgHg8LZUUoGA6PICk60J3Z2+c6+QWWCOv9
	DJ4y6gvo0HR1wQXb8WVHw3anrmDFp42VLJRpL9LGDa/b3MekGiFX0xBSL496wl3e3yq1
	AgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Y8vYdZLL8dFsRmtPz5y/3UuzOFStPEHLUEHpl22lwto=;
	b=tMXa4YmzNSNs+iyr/UEeCVCqt0eIOGH8hlrC3tQqlM2d+mCdmPRHLlSSrGY5/3B+bb
	cwpnT0uTILJ05ZkqowiXoZxzuTg6VUoZStVjScbkwTt7RPcOO5tPjWJru/NuunDrCHVL
	asDT2wQCIRxDkQD+2/W3/Friybqf3BNMW5IrWnaHLv+LOZ/zpdUR/oTgdkVMd1vOt0Vb
	gEts667HaE6vxMO4IHReiyT9DxcmAWvVWB6aJVJL477S+fytnfb9hmcoEl8VOdmfhByD
	K9AYS/hT3kVrkmZnfuCY14J2iotgilhUdAr42/bBs0WrIw/bV/dlwjzdRRf3J4rS/07j
	Z1DA==
X-Gm-Message-State: ALQs6tCjV2mGSTkMYhiXW89HkfThHzVieNLiESKalSQG04r3UGpwXN8/
	e6cE7N46NpGyAzGn+vwsdGVATl78dhFmnrFsM00=
X-Google-Smtp-Source: AIpwx48OtEMi50o0UoEWyM1S0kQub5iLVVLf6AtCdzljk6L2i/mVa8YXw6jYD4XtrZbO57+hPqGVez2MS2yRUdFz00I=
X-Received: by 10.99.98.69 with SMTP id w66mr2763095pgb.55.1524081750866; Wed,
	18 Apr 2018 13:02:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.190.8 with HTTP; Wed, 18 Apr 2018 13:02:00 -0700 (PDT)
In-Reply-To: <1503144441.3803647.1523538756955.JavaMail.zimbra@enigma.com.pl>
References: <1523526293-14340-1-git-send-email-jdebski@enigma.com.pl>
	<20180412101612.GJ7593@hiutale>
	<1503144441.3803647.1523538756955.JavaMail.zimbra@enigma.com.pl>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 18 Apr 2018 13:02:00 -0700
Message-ID: <CAMKF1sp=t4LM4qdCKu-9qVq14ih1Rx_mxK_=ThbD5QCq5RGFrQ@mail.gmail.com>
To: =?UTF-8?Q?Jakub_D=C4=99bski?= <jakub.debski@enigma.com.pl>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git.py: Added handling of the user's password in url
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
X-List-Received-Date: Wed, 18 Apr 2018 20:02:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 6:12 AM, Jakub D=C4=99bski
<jakub.debski@enigma.com.pl> wrote:
>> Maybe this is by design to prevent credentials leaking into bitbake
>> recipes.
>>
>> Alternative is to set the usernames, passwords etc in e.g. ~/.netrc
>> and ~/.ssh/config files which have the same effect.
>>
>> -Mikko
>
> Certainly, credentials could be set in other ways, but there is some
> inconsistency with other fetchers (e.g. perforce, wget, hg) which
> use password from SRC_URI.

that merits an entry in bugzilla

