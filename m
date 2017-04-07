Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
	[209.85.214.49])
	by mail.openembedded.org (Postfix) with ESMTP id 6E20477D6F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 06:37:51 +0000 (UTC)
Received: by mail-it0-f49.google.com with SMTP id a140so38251243ita.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Apr 2017 23:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=9nknJfLRmsvqL3Tw7Hk3DTqNyX50WKintkvMHHC7D2E=;
	b=HsS6iBgWel7NX/jaW80JVbCGzcbPmqYawTb6WjoqPGyRDj4ito0HDtMj5FTLovEtH9
	GVvRxy0nGUGFk/aWNm29g/qiQ9z7VzDGmT0MDlDUVe+VxsUtAAR08ZUr2BeHDtyrgDOc
	Jl6VN8f9pdlGJGnYuz+NU0bcVs7bCczR4UyfCM1Bf0DJ0goRbzj8Y3BDa4qwpB9t6Pfl
	1AfgI/02l+1Ea+OivRv1DJX//nRhXhHjoKxY4YDDfxE8LQKx5f3kKVgZDGJ8U5s5oyTN
	2VBvxy9O8eJwY8CJqDiOauZyCWWUW/aBUjhQ6WRbrZMAVDoZgXWefUSpwVRXAL57psHV
	7I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=9nknJfLRmsvqL3Tw7Hk3DTqNyX50WKintkvMHHC7D2E=;
	b=S7MthSazsp4PL+hpNeGJz4tW4PhojGJgNY77iKgslrnCrwLk5ADWDS93WmCDKRCBRx
	lMSbssC2JFOWTvLPmW3Ss8/MsHdAd5RTlpjyp5/A6AqTuvtUWYR1r6f1HpS+NptO6s75
	h+TOs+gLMce2HuMdiYJBKJlYS2ouojq1/uRoBagZu54hM1HdHDX/eDiDxZZlVOSUDRp0
	ffoB9s7PGnoB7E0HQUzFcPfBJu1m5OPRoGNLoqIFzPGPhvDTA82PAuBCBRcON7jJysXC
	q99siSJ5diTBLSMlD7v+KrVGCTT3nr5jUnNDQFx0dHnptVbRjCMH87QqmU1/T3WH3HhU
	T3/g==
X-Gm-Message-State: AFeK/H3NVmb+QFvXnJ5PBQeUdLSkfFbMLiHeRhzCHbaqekkfpx2i+BTp
	Che0AW2iXTcDAbr4
X-Received: by 10.36.29.83 with SMTP id 80mr30929103itj.2.1491547073296;
	Thu, 06 Apr 2017 23:37:53 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8EAD9.dip0.t-ipconnect.de. [93.232.234.217])
	by smtp.gmail.com with ESMTPSA id
	u124sm1079931ita.27.2017.04.06.23.37.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Apr 2017 23:37:52 -0700 (PDT)
Message-ID: <1491547069.10884.55.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 07 Apr 2017 08:37:49 +0200
In-Reply-To: <9a743ad396af642fc20961e38fb7f6c5752f2446.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
	<9a743ad396af642fc20961e38fb7f6c5752f2446.1491514854.git.paul.eggleton@linux.intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 09/11] lib/bb/siggen: add collapsed mode to compare_sigfiles()
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
X-List-Received-Date: Fri, 07 Apr 2017 06:37:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-04-07 at 09:52 +1200, Paul Eggleton wrote:
> If we just want to drill down to the actual differences then we don't
> need to see certain things in the output, e.g. basehash changing or the
> signature of dependent tasks. This will be used for comparing signatures
> within buildhistory-diff in OE-Core; the default mode as used by
> bitbake-diffsigs and bitbake -S printdiff remains unchanged for the
> moment.

This sounds interesting. The bitbake-diffsigs output I got for the
yocto-compat-layer had such useless "basehash changed" comments. Should
we add a mode parameter to bitbake-diffsigs that allows choosing this
collapsed mode?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




