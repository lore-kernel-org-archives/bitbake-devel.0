Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QWdoE-00072y-5P
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 Jun 2011 02:18:14 +0200
Received: by vxd7 with SMTP id 7so5524066vxd.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Jun 2011 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:sender:in-reply-to:references:from
	:date:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=x5nlhsxQEXK65OJ4XZQBgfHu1A/5fZ2pLOVZtLBQagA=;
	b=xfmqSLQ56Iyz84Uqi8Ll87hBHz48iXCylnjcN96zJaFuMTJtetLcVWZU5IHnlaQWuF
	HJR3mc2YXnigzjKlOkhWqtaWtrzYZdk9sJlJuQtAs51j+cFRgvJJYbG6xfi4smvE88S0
	X+eALBeaVT42d7SGguhFs9ECCDUr0zbKn4KfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	b=fEoCJK8Vr6kDngopwlNV9v4o9Ech3W9GyWItDOxI6Xs1m6+/4Zok0MLQkXVc9ANAxv
	cl2/evBhB6+EVL4fRTBVOpySQr93/B4Dy39Z8NxQs5OtkyoysmhTSdWVbPE5UBj1JE92
	3IldQR3bsyxC0S3yjzwixxSneE64pQddPSfp4=
Received: by 10.52.111.71 with SMTP id ig7mr660717vdb.209.1308096505077; Tue,
	14 Jun 2011 17:08:25 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.181.2 with HTTP; Tue, 14 Jun 2011 17:08:05 -0700 (PDT)
In-Reply-To: <4DF7F261.6020007@intel.com>
References: <4DF7F261.6020007@intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 14 Jun 2011 17:08:05 -0700
X-Google-Sender-Auth: aggC2v1nhI0o0_11SyWVceOxdpc
Message-ID: <BANLkTin50uRUyWWQ6oAtFQ9RC2r=E7_pug@mail.gmail.com>
To: Scott Garman <scott.a.garman@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Bitbake exception handling syntax.
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
X-List-Received-Date: Wed, 15 Jun 2011 00:18:14 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Jun 14, 2011 at 4:44 PM, Scott Garman <scott.a.garman@intel.com> wrote:
> In a failed attempt to make bitbake pass the parsing stage with python v3, I
> noticed that the syntax we use for exception handling is inconsistent.
>
> The old way is to do: except ExcType, localvar
> The new way is: except ExcType as localvar
>
> We're using the new syntax (which is python v3.x compatible) throughout most
> of the code, so the patch I'm about to submit cleans up the remaining cases
> using the old syntax.

That sounds good to me. I converted all of them at one point, but the
code has changed since then :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


