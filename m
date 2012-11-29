Received: from mail-vc0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1Te74D-0007yL-9S
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Nov 2012 17:34:33 +0100
Received: by mail-vc0-f175.google.com with SMTP id m8so11006421vcd.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Nov 2012 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=21X7aCHQmiPo39Fo8BIGRG6dR4j1hsLzUXh2Y3A1nv8=;
	b=Ze9TBr9CotDugbaOpayT/xlVU/bKLqSxjU8Gs073wmdEfz91cv/kC+if5QCQatTHys
	e/GIPE2ZqinjGjZf84Gj4ArSBlAkYD7I1Fmx6bDvH/qlIXZvKYF33G723QX26s5bhUjG
	Zn5KlHFIWFiWtbCgdKH6Q1SSvE96MwY15xOtzrcQQanFdAAsz5r5GG75R9unV32bQhDp
	3zZArTiD1AkKf3piImNAVRNE6ELhoftjk8H/XDzFn1SwwySeOofMa/3U3UHqdBwVcNSZ
	RKqY3j5KHx91s6AgqLiX0a3bC+4yKhgGEbsE/eexflgCRyzizsQWMe+gQhWRBkaMi1sQ
	OB7g==
MIME-Version: 1.0
Received: by 10.52.99.197 with SMTP id es5mr27798056vdb.7.1354206009012; Thu,
	29 Nov 2012 08:20:09 -0800 (PST)
Received: by 10.220.155.5 with HTTP; Thu, 29 Nov 2012 08:20:08 -0800 (PST)
In-Reply-To: <1354184946.4943.0.camel@ted>
References: <1354184946.4943.0.camel@ted>
Date: Thu, 29 Nov 2012 11:20:08 -0500
Message-ID: <CAHUNapRmG=8YLOeVEvYLz7T7N73ODp42M8PphVA8GZwwAijiHw@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data_smart: Improve get_hash to account for overrides and key expansion
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
X-List-Received-Date: Thu, 29 Nov 2012 16:34:34 -0000
Content-Type: text/plain; charset=ISO-8859-1

Thank you. This patch solves the problem I was seeing.


