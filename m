Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id 5F54C73173
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 08:33:00 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id 5so113951496ioy.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=nMDcEqU/fczrIXQju0WKU9QfJZyT0jf456F3lf0I3c0=;
	b=G8Zydf3ToqD69Cm0+R+7vYSmm2pfgMGqSY0S6f+tgr23Hg1IhfO+txHrRGJoxZ5DIM
	Txf+CERcHqI2yXq3Xv9H7zozKiVgt1rZ27Ewx5j3NL8knV18k1m6hVa86W1zW+3TKSoz
	wj0C7ds07xkFGmDzJvPA2ADbOXTQ3SomdK4Q12petmpWEutbGPUJ6iF7PrCvjCVgoEcf
	jAMc12kVjjDaOuZZTtQoSU6yVejUH/IlB+Wm3w0sYy6u2JxlQHKD5KWOWqk7YvR5R+DM
	+sqfuDWHGCQDFcgj7BDhL9SW0uFJXtIchpLsRouSU+Wh69ltlkwMZW96OEfjID2Cn74A
	qzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=nMDcEqU/fczrIXQju0WKU9QfJZyT0jf456F3lf0I3c0=;
	b=mHpwukPMlzsYoX3k6+xMvO0LcOVnqEn3ZsoA0tW7379CD/xyjL+AsWfsvaV3FMju+B
	2b36Nsm6hhb5WFY8BFlRGUUWCrkghna9ORc/BZIiv+FGzBbHQsCdEmFEojiYnRj4qBzo
	+S2vNWtwXwM8XJ2TvdLnMV+bzdfsuyipQkICCZV8fGAR85GGKnA4Cal5wxzUgiR/VcWh
	FKSeqceB7c1wlL5SbfSJaA1QNNM5/nVF6EHAht1XqbTjvh703GNvAW5ruQ9dzqLjQzgt
	upX4Ukm45Wivlic/KcqKNe85IsCbnmykW5Rkh2x+AJt3ebkojV6gWjU3pVvIK09iSly/
	g4GA==
X-Gm-Message-State: ALyK8tLl27Qd2IXNF/2M/t5HsEqOjYh55uS+A/HgMzX1smLRUu1hnSPwTNQTU92JrdO35rsj
X-Received: by 10.107.165.203 with SMTP id o194mr22103202ioe.28.1465806781325; 
	Mon, 13 Jun 2016 01:33:01 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8D775.dip0.t-ipconnect.de. [93.232.215.117])
	by smtp.gmail.com with ESMTPSA id u67sm5933757itd.1.2016.06.13.01.33.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 Jun 2016 01:33:00 -0700 (PDT)
Message-ID: <1465806778.28019.1.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 13 Jun 2016 10:32:58 +0200
In-Reply-To: <1465511881.13979.156.camel@linuxfoundation.org>
References: <1465511881.13979.156.camel@linuxfoundation.org>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart/utils: Add 'd' to the context used for better_eval in python expansion
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
X-List-Received-Date: Mon, 13 Jun 2016 08:33:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-06-09 at 23:38 +0100, Richard Purdie wrote:
> If a line like:
> 
> foo=${@' '.join([d.getVar('D', True) + x for x in (' '.join([d.getVar('FILES_bash-' + p, True) or '' for p in ['lib', 'dev', 'staticdev', 'doc', 'locale', 'ptest']])).split()])}
> 
> is added to a function like do_install, it fails with Exception name 'd'
> is not defined. This is due to a change of behaviour in python 3 compared
> to python 2. Generator expressions, dict comprehensions  and set comprehensions
> are executed in a new scope but list comprehensions in python 2.x are not. In
> python 3 they all use a new scope.
> 
> To allow these kinds of expressions to work, the easiest approach is
> to add 'd' to the global context. To do this, an extra optional parameter
> is added to better_eval and we use that to add 'd'.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

I'm building Ostro OS with this patch, which is where the scoping
problem was first found. Seems to work for me, so please include it.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




