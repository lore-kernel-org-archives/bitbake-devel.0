Return-Path: <ross.burton@intel.com>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id B054E6BCA9
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 15:30:33 +0000 (UTC)
Received: by mail-it1-f196.google.com with SMTP id v143so10348927itc.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 08:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=m8NwzW95yhyNTnhJMpE0RQlYQPfnfNN3x2PBJHdsIM8=;
	b=FEK/u9+i9ZbqVieRJJCUe52nqKVV4Www281+/fOehaAgDW529iF4yudjiviUipIIuU
	6j5Csqs0UAIKm8wo0W2FViUHrE2UfXO36ePRHe+fXN9ehKaUKSwsse2Ds5mzTbn9oACM
	ezWD+af0PgjfB9vGfIWlTGITh7njjtLDuaB1fz9F91MzoDvo/Uhd6vXJdYBez/3oR8Gb
	p40sJKIg+zBSK90/hidv5xTZKVWV08h2bPpEi2rqU23w5KjFX88iI1NhsHLhD0rRkd/s
	jJGs+zpcrEHzjClTOuhRGC3W8wecU3iN5Fk8ysUM56CyrWKsNOo+wgbIjDBHxn6PANe9
	0KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=m8NwzW95yhyNTnhJMpE0RQlYQPfnfNN3x2PBJHdsIM8=;
	b=iztOepzga5BhbCznH0ZsS7T1eHSrFK/zH0xmhprI2EyUaHQZgQG65jOmy8cNlFSA2O
	TvG3xDdFKHibtszio25FOU/HkPDdmZ/82Cnf6p+pbTnuk4G4828FL8xXG7k0gJzTkT7Q
	TXYC+gvQxVZLNl3zGQbEq45PL8Dt1OXg4mH+pNlPW18pXOGFWQgsCXxFYjNBdGUYnNq3
	Sq3CXAvVcVvhuyMjw2GrWww2GeYtGaD7njpTZSmX3KTHBcato7BEKba5I5mbbFbXIbBO
	3/pM0QxFAW4aanmeTj4DQOUrI7TmvFfNitaIyLfIPD/Tj3tgjRy0gghchgoH2P+kDQ9k
	sHMw==
X-Gm-Message-State: APjAAAVgfdYflnRoE/iYexM7mgkJ0PqJFLG2keM6RUjsLDKTXq69f4aR
	8DdG1T5VFhczx1RdFgCS8hBVZrsBNdLwCdvT/H7q2aPl
X-Google-Smtp-Source: APXvYqxBHkDK+qoyHz/gkJ8AFPZ16ec3dFb9epBiJD6AztHhUg1wWfePmBNHLZWeK8KkT6q9Exbg1DSDD56XP3uNh04=
X-Received: by 2002:a24:4145:: with SMTP id x66mr6075068ita.130.1556724634233; 
	Wed, 01 May 2019 08:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556186399.git.liezhi.yang@windriver.com>
	<d37712258af9b6fedb9e1586ace28908bec88391.1556186399.git.liezhi.yang@windriver.com>
	<9f8a038abf7b7eff75038ccef5f066bfd37e58f5.camel@linuxfoundation.org>
	<0c45f88f-6056-2fa6-1db1-f7ce413ba0f3@windriver.com>
	<CAPbeDCnOwvCVx-okYiXU0CXjWLxDGBX7xQc4ij+_iGgd2t-T-w@mail.gmail.com>
In-Reply-To: <CAPbeDCnOwvCVx-okYiXU0CXjWLxDGBX7xQc4ij+_iGgd2t-T-w@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Wed, 1 May 2019 16:30:23 +0100
Message-ID: <CAJTo0LapxS3a00e31b9ur32x4XtNPTWUSmw4i=_x9AjbLuECjQ@mail.gmail.com>
To: Jacob Kroon <jacob.kroon@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 2/2] bitbake: build.py: check dependendent task for addtask
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
X-List-Received-Date: Wed, 01 May 2019 15:30:33 -0000
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2019 at 11:51, Jacob Kroon <jacob.kroon@gmail.com> wrote:
> I'm getting a lot of these warnings after removing tmp/ and rebuilding
> my image from sstate cache.
> FWIW I use rm_work.bbclass, and regularly use the
> sstate-cache-management,sh script to prune old cache.

There's a patch I hacked up in master-next that shows where these
warnings are coming from.  Yes, this patch produces two warnings per
recipe with rm_work enabled.

Ross

