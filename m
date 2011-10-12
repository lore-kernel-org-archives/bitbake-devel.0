Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RE4Xb-0002GW-14
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Oct 2011 21:32:35 +0200
Received: by wwf10 with SMTP id 10so6767542wwf.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Oct 2011 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=LPHL8tkJDOPSQxUYsTosdeIBUeiDMUOV5UcvKPDu08E=;
	b=XflFUf+M+MpSk/pBISZwBv0W87ynYQ/kbZC4IVU0nRAFy+nllCcHvYrquX2L0XIBR9
	mtiaJ2hUxF4Gf2olBOyp4tWaFmaEdFUWjvhY8TsOhA6z3PGXKTus7AAZf9sglkJTaOQM
	82USjxNama/P8x9xOnQ8yt71JlDKCnLtm/quc=
Received: by 10.216.72.72 with SMTP id s50mr146865wed.39.1318447322114; Wed,
	12 Oct 2011 12:22:02 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.160.80 with HTTP; Wed, 12 Oct 2011 12:21:42 -0700 (PDT)
In-Reply-To: <63dc9197eb483863e1cec5e58f036b7493850787.1318352470.git.josh@linux.intel.com>
References: <cover.1318352470.git.josh@linux.intel.com>
	<63dc9197eb483863e1cec5e58f036b7493850787.1318352470.git.josh@linux.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 12 Oct 2011 12:21:42 -0700
X-Google-Sender-Auth: BYF3mmKs-KPE6DbNJ6NahimDjV0
Message-ID: <CABcZANksOeUAVw0EmcTBVK61NE8GoE8Xq=4yCZdkuihVB7FqUQ@mail.gmail.com>
To: Joshua Lock <josh@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] fetch2: improve usability of checksums
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 12 Oct 2011 19:32:35 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Oct 11, 2011 at 10:07 AM, Joshua Lock <josh@linux.intel.com> wrote:
> This patch improves the usability of checksums by only requiring one checksum
> be defined.
>
> Further, checksum verification will provide as much information as possible
> at, rather than a bit at a time. No longer will you need to run fetch, see an
> md5sum mismatch, fix it, run fetch, seen an sha256sum mismatch, fix it and
> fetch again. If neither checksum is defined we now report both missing sums
> at once - rather than one after the other.
> Finally, if both sums are incorrect, we'll report both incorrect sums at the
> same time.
>
> Fixes part of [YOCTO #1399]

Nicely done, the fetch/mismatch cycle was quite an annoying one :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


