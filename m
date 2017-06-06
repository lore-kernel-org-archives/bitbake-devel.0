Return-Path: <vijaikumar.k@mistralsolutions.com>
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com
	[209.85.128.177])
	by mail.openembedded.org (Postfix) with ESMTP id 0C42477E51
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Jun 2017 07:16:21 +0000 (UTC)
Received: by mail-wr0-f177.google.com with SMTP id g76so49561995wrd.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Jun 2017 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mistralsolutions.com; s=dkim;
	h=mime-version:from:date:message-id:subject:to;
	bh=vyicOb6DYq9//t+bGNtt9WAG+Q9BOhza+MUsC4ASJS4=;
	b=vKZEoOQoo0C4csb51qixO5jpT9iFdUQs04SJfECPVvT+Y/4hR4hehRFw9myCwSjzYg
	GR3bU961VfGnR4n6t/z5Keuf8B8Orwf5ewb0jeOGw6TmSNZfY6+niX+rMK5Zq+CgfHPo
	JIDTNhNOebZD2GQDzz6SGBB9hzQJakHjPwV44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=vyicOb6DYq9//t+bGNtt9WAG+Q9BOhza+MUsC4ASJS4=;
	b=fogKI4k792KnkHoowlvMU7POT2CKtjux/ILGnP+fqhxScLNTG0sXDh1l75Rn6wcwg1
	LTYoro0hwrrwpcFxN9fEuEAL02Rbp/1rwyFDvHaJ22NVSATyju8h7Z8KTKdtyCanzUct
	7lMpS+5JQXjN8Tgujwr6HA3ojeoNYQvhqPQh+v2ZW2oLUD4nH0lsWdtR4NMo16rQVU01
	8mDLd8rv0Z+JKpeoW1ki3RbHxhSmhjDrKzp0caMV94Tw/Zd0m/I8SwPblrAsS+NeDRHq
	Smu3iKt4adJin5X57ImIVxIk7N8BxlyYs3SPrpQJAgcpUG+PeHckFx+JP4AtFgaIWkjw
	6dBA==
X-Gm-Message-State: AODbwcBqVSM6hNlL98DCsBzz52TkNahUPMC1cVRrak7zAJHSWfTQ0iYV
	p6tV3pehPFzE6AdwWRbMdmjDOfgH+tc5
X-Received: by 10.223.133.35 with SMTP id 32mr4163682wrh.9.1496733382322; Tue,
	06 Jun 2017 00:16:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.18.203 with HTTP; Tue, 6 Jun 2017 00:16:02 -0700 (PDT)
From: vijaikumar k <vijaikumar.k@mistralsolutions.com>
Date: Tue, 6 Jun 2017 12:46:02 +0530
Message-ID: <CADOTBT2Ps9wzWRGogvZJ1PX6zeuAUXhiyzEjiqDdzsbKDCHLGQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Overriding bitbake functions
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
X-List-Received-Date: Tue, 06 Jun 2017 07:16:22 -0000
Content-Type: text/plain; charset="UTF-8"

Hi All,

I need to override an append function in bitbake. Just wondering if
there is a way to do it.

do_configure()
do_configure_append()
do_configure_append_mymachine()

I want to replace/override do_configure_append() with
do_configure_append_mymachine(). Is this possible? I do not want to
disturb do_configure and do_configure_append function. All the
functions are in the same bb file.

Thanks,
Vijai Kumar K

