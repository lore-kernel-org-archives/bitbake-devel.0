Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id C01BB78169
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 20:01:57 +0000 (UTC)
Received: by mail-io0-f172.google.com with SMTP id o12so143764956iod.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 May 2017 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=lLQjA5EoZRJMSqSiySUpSuTfb6dn67oHwMmTcUkYduk=;
	b=Z0oHeV7r7SqPn2ISOEnwYrDtZKd5nKKhpBjKkasTFSRxdEa0aI9QzmpqhhDqmB2YVF
	WB69ZngkCHltBo6NKqwxjCmTN7Vg0iQEmAYdJKXAuZzJg7exwQiHHbX44lbv/93vZj/Z
	H0o8whYYuST3eUoFt4zhSDb+j3O356S9bKIiOddmjN9BkOLEAGpwAsfZX7isFYwvlXSx
	GrLCj92OZ3Tj89gZC0pNktqlTYttnqyiGL7/38djRS839j9OrmSPYMXI/kryY23jtpxf
	KzQMH8TLudWULVMfdcjA0GehDqA8NDRhEXOHPpBs4CIFyaiEaTYHMeLMvbTL2yPWkAV1
	daMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=lLQjA5EoZRJMSqSiySUpSuTfb6dn67oHwMmTcUkYduk=;
	b=lH27duB1kuSrULHZGWSD2BAPbdMULt6NiXv0aAf7fFkERXsr0gxy36RdPYcy8shzmD
	9vLGPo4TEp3j+DkUWJRKYaum1LK8FtqBtBSztI7QY5gZOvHVi3rJVVzC6dYbInuvXGbt
	t/agoTnoR8nGB2Ah7W41CXIX8ycUQWRjZ9y8p+x92u3QzfYe8GceTUJwA97RaiSUJGN0
	zIjuiIq+dLNPyvRYpI/dJv/kc2gQnKz5ahHSj95WMgwGKNzGvs1eNXlr+V568Z7iNp7N
	c+HFvbB6vsGYQWuijOny1ItLC04vsslPJWht0ikUCYMdcHjwDK7EB+4S7ntvpQGPP82f
	VqvA==
X-Gm-Message-State: AODbwcCYFJoGl7EenkIsJ2K5wvNzneSK/vwjBwP/UPjoDjNzbCpJi3Lr
	HgmnDRLdXRAYVdEjpjs=
X-Received: by 10.107.33.136 with SMTP id h130mr39103881ioh.57.1495742518478; 
	Thu, 25 May 2017 13:01:58 -0700 (PDT)
Received: from pohly-mobl1 (p57A56C57.dip0.t-ipconnect.de. [87.165.108.87])
	by smtp.gmail.com with ESMTPSA id
	e186sm3343632itc.21.2017.05.25.13.01.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 May 2017 13:01:57 -0700 (PDT)
Message-ID: <1495742514.16923.97.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Christopher Larson <kergoth@gmail.com>
Date: Thu, 25 May 2017 22:01:54 +0200
In-Reply-To: <CABcZAN=d7BHGOM9602pfbA4N6chDB8b8RDKB4xo6fhCChDx0Rg@mail.gmail.com>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
	<CABcZAN=d7BHGOM9602pfbA4N6chDB8b8RDKB4xo6fhCChDx0Rg@mail.gmail.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
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
X-List-Received-Date: Thu, 25 May 2017 20:01:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-05-25 at 08:50 -0700, Christopher Larson wrote:
> 
> On Mon, May 22, 2017 at 3:50 AM, Patrick Ohly <patrick.ohly@intel.com>
> wrote:
>         Having a .bbappend without corresponding .bb file triggers an
>         error or
>         at least warning, depending on the global
>         BB_DANGLINGAPPENDS_WARNONLY.
>         
>         Some layers (for example, meta-freescale) avoid that message
>         by only
>         adding .bbappends to the BBFILES when the layers they apply to
>         are
>         present. Others (like intel-iot-refkit) avoid such .bbappends
>         by
>         falling back to global assignments with _pn-<recipe> as
>         override. Both
>         is complicated.
>         
>         Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and
>         ignores
>         all bbappends which match a file pattern in that list. This is
>         an
>         easier way to have bbappends which may or may not apply to an
>         existing recipe.
> 
> IMHO this makes it too easy to miss legitimate problems. By adding
> them only when the layers are present, you ensure that if that layer
> removes the recipe you’re appending, you’ll immediately know it. This
> hides such actual problems by suppressing for all optional appends
> across the board.

I understand that it is a double-edged sword. It's meant for layer
maintainers who know what they are doing. If a layer maintainer prefers
to be warned about missing recipes, they can simply ignore the whitelist
feature. Layer maintainers who use it need to ensure that they have
tests in place which will fail when the bbappend is no longer used.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




