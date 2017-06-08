Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
	[209.85.214.46])
	by mail.openembedded.org (Postfix) with ESMTP id A48BA6010B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Jun 2017 06:24:10 +0000 (UTC)
Received: by mail-it0-f46.google.com with SMTP id r63so15740112itc.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Jun 2017 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=fZwKxkj1e4IjqJ9v3irD9zfzsOMFAeYktolDp7ej4wM=;
	b=lWaOMdtrZ8IzrEebTbcLYEU9WwvbuahsP75LfzIQUscAkqLPuGN1loUdZ0CvrysFWP
	DhN22pSkeZKeRylMP/sWSVaxuToYnwW6ATO4CLPkRM2RBOcTLBHxb2tppY2Ja+YQMOhZ
	7BtprQRM+m/gEATBycRQvZ+794vqnhErV5aehZqSE/zhcojY6ydUi2VGyBWeaPm4Yh9s
	Ehz+8fAdEHcwaCkAENk1IbmOuZ4J3VmTo9Us0PAJzKPeOhIJx7AmqA8H/c5/qDUe01me
	7foKhnl9eB/l+XOa9o+nogbIHHjYGnb3lxDaQuoiWR50Y2YVVAbw+v8/kTUpRimKRheV
	ezBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=fZwKxkj1e4IjqJ9v3irD9zfzsOMFAeYktolDp7ej4wM=;
	b=AMjiBY3i3LOE6NXUIHm+wK5YJtP/Nv2vICCE7uBJWnBwSuIwsnBSgvx0DlqiYefp70
	0yA3KGwBTXRmBvCHIuikt1B3b74LE+qwFewgdwP1koTLf4bNl7KY4lDvw5oJkYpRoXLa
	XOc0AB8bY5rv5sNAw1XCOCJRqFEPnVqP46euAet6/I5i0KtfZviM5+6FKMDmqSdvwTVt
	m7ywrgAjwO1utbmM5FG0f6zyttNlJzXZFiiN9S890h+Gc+spklgU1IBHXz1iOxzaoFp3
	SyJauLm5GkSMdmHHDtKqun1nLrzrmTzhFdA60xAMn7W4QcxjS50olx4EYTpOt16KgqDo
	YZRg==
X-Gm-Message-State: AODbwcB6AIMHpXc5wP70/1ogHjdbLy6ooNy+tnyATsPTzfn0Eo/Sfe4x
	Y7dZp7HkNpaxS7Hm
X-Received: by 10.36.181.78 with SMTP id j14mr4030105iti.82.1496903051773;
	Wed, 07 Jun 2017 23:24:11 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8CE54.dip0.t-ipconnect.de. [93.232.206.84])
	by smtp.gmail.com with ESMTPSA id 93sm1888050iop.11.2017.06.07.23.24.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 07 Jun 2017 23:24:10 -0700 (PDT)
Message-ID: <1496903047.30163.127.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Date: Thu, 08 Jun 2017 08:24:07 +0200
In-Reply-To: <4c164d2f9d254f8cbb09e54fe6d9424e@XBOX02.axis.com>
References: <cover.36a6c17ae3fab020393e82b397fb5a16681be9d7.1496843701.git-series.patrick.ohly@intel.com>
	<c05bcbe8dd83f969f56e7ef93a2ea545fab4cf2c.1496843701.git-series.patrick.ohly@intel.com>
	<4c164d2f9d254f8cbb09e54fe6d9424e@XBOX02.axis.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/2] ConfHandler.py: allow inherit or include without parameter
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
X-List-Received-Date: Thu, 08 Jun 2017 06:24:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2017-06-07 at 14:47 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Patrick Ohly
> > Sent: den 7 juni 2017 15:56
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH 1/2] ConfHandler.py: allow inherit or
> > include without parameter
> 
> Change "inherit or include" to "include or require".
> 
> > Writing .bbappends that only have an effect when some configuration
> > variable like DISTRO_FEATURES is changed becomes easier when allowing
> > "inherit" or "require" without a parameter. The same was already
> 
> Change "inherit" to "include".

You are right of course. At least I was consistent in my mistake ;-} I
guess I'm still struggling with the oddly named "require" vs. "include"
distinction.

I can send a V2 if there are no other objections, or perhaps it can be
fixed up as part of merging?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




