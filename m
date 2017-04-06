Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com
	[209.85.223.176])
	by mail.openembedded.org (Postfix) with ESMTP id 04FF977921
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 08:43:09 +0000 (UTC)
Received: by mail-io0-f176.google.com with SMTP id f84so25313667ioj.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Apr 2017 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=OIqk7wBEdLPL42x/QLUVoOU9OV05WI/l/n0FaZvHEdw=;
	b=XcmNhlvDdxsJxfDs8pGm5ouZFEIQxKDLlZLeo8vX/ZcXvpEwAAaJiNyf6M/mROvOOr
	z8t7ta3QobI9qzlnRlukx8OgtYYDCr41WelfawKnLB7npsI+eJm7A0Ts8qNwuEpP2MYn
	D1lUulN4joPMSNtdK0+3VdZX/YYjzKciw8zXRF5yb8nZguZiPpC1bEJQNgN7+PuNWRrL
	oq6+sKzquzXVklsC0llwoFV4DMGlEfh/c8vbNwWvULU9Vg5fVINHbzPdosKE51a13O+u
	z0oDsX0TceDRLVvfG2SddTZhNNtLZCdTqb20H8ceJBqMFQXiFlcOkROvn2awatzxbK2c
	pW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=OIqk7wBEdLPL42x/QLUVoOU9OV05WI/l/n0FaZvHEdw=;
	b=p+239hKYH2vjKmrl5l/pn97D3UO5BgRcy46YGZWNoXGzVBROhxP9Y/8L7/Ff2M1yBy
	1LXqUpZoBOjNe86eGcmc1iTwIMdrQi/7EXV67+iWZhvUyBTyRaOzUGqRRy3xgDCG9njQ
	ekKEa2ozssliFoJuVteVKcwh1tCGIoPEhN3XKrgNStRB3EZZEMNa1UX+VBwAa1AoKma8
	yfHwpuXTVo/lOciHhKed08/fIB7Qacgm+PwrdDk0ZvaXIjCWjOFnhQFOLZqnHQ8R4UCd
	hPBhWLK+OEgQKc6oPz0V413SJeFv11ZTEa40l0fNN7khDuXEIWsajuQWCGpTDt7zjU/G
	mU4A==
X-Gm-Message-State: AFeK/H34q3kZ1cXcOSkRWDcIFjk0QhprAhU0mTdm61/7BlUupmIbEgAkvjcNNEVteiMAkgCV
X-Received: by 10.107.174.220 with SMTP id n89mr33924700ioo.166.1491468191072; 
	Thu, 06 Apr 2017 01:43:11 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8E7C4.dip0.t-ipconnect.de. [93.232.231.196])
	by smtp.gmail.com with ESMTPSA id l79sm584778itb.24.2017.04.06.01.43.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Apr 2017 01:43:09 -0700 (PDT)
Message-ID: <1491468186.10884.38.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Juro Bystricky <juro.bystricky@intel.com>
Date: Thu, 06 Apr 2017 10:43:06 +0200
In-Reply-To: <1491428045-10132-1-git-send-email-juro.bystricky@intel.com>
References: <1491428045-10132-1-git-send-email-juro.bystricky@intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker.py: multiconfig support for findBestProvider
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
X-List-Received-Date: Thu, 06 Apr 2017 08:43:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2017-04-05 at 14:34 -0700, Juro Bystricky wrote:
> In a multiconfig environment, a tinfoil call such as
> 
>     tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc")
> 
> can fail with an error such as:
> 
>   File "/data/master/poky/bitbake/lib/bb/tinfoil.py", line 373, in get_recipe_file
>     raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
> bb.providers.NoProvider: Unable to find any recipe file matching "multiconfig:arduino-101-sss:gcc"
> 
> The culprit is findBestProvider (only called from tinfoil), which does not
> handle multiconfig. This patch fixes the error and the tinfoil call returns absolute path
> to the recipe, i.e:
> 
>   "/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"

So tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc") and
tinfoil.parse_recipe("gcc") then return identical data, because both end
up parsing "/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"
without taking the "arduino-101-sss" config into account?

That wouldn't be correct.

As far as I understand it, the mapping has to be:
multiconfig:arduino-101-sss:gcc ->
multiconfig:arduino-101-sss:/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




