Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>) id 1Tqo7I-0002zn-ES
	for bitbake-devel@lists.openembedded.org;
	Thu, 03 Jan 2013 17:58:05 +0100
Received: by mail-wg0-f43.google.com with SMTP id e12so6953452wge.34
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 03 Jan 2013 08:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=W6m0sRyQSE+fK2w5CiiN7RDyjVYAM66xjJrzcMgu7QE=;
	b=ewUzs8gowo69GUU7Xe3KnW0XZZKDtCZZpQlxZ8pIdUHR8z9Wb/aAgeCeuOitKud+Po
	fjU6kCFP4+IRuGnduNrNSAIv3jHqIO8g2k1tbAcw6+kVL22EmalbfooFIBa6ev8hzLd0
	25m4IrjD4RUTD30l/LoSTL4aeIq8Flc3OcjxrVUZ4YN8e6XFgUANiuFaVOzdlCFai/cO
	8f9qwXhxVi9bhmemel0eLH05Rrcs+WPjkXQG+IJ/3nbZX0nWnuFR2MmiDER52JL9QWuM
	h02x61ahhAjMBcYqpF3V6ipO6lvZo6ykG3u+k2jD5Dz2pgMyqQT7ONepNgGOfzMlvEzz
	yNFw==
MIME-Version: 1.0
Received: by 10.180.73.80 with SMTP id j16mr76653342wiv.5.1357231380466; Thu,
	03 Jan 2013 08:43:00 -0800 (PST)
Received: by 10.227.132.205 with HTTP; Thu, 3 Jan 2013 08:43:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1301010855180.18858@oneiric>
References: <alpine.DEB.2.02.1301010855180.18858@oneiric>
Date: Thu, 3 Jan 2013 11:43:00 -0500
Message-ID: <CAHUNapRE-wRQpPhGOJDFcUkAMERKcGJNaoWcN7jZFOmkwbr60Q@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: still confused about _append and OVERRIDES and = and +=, argh
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
X-List-Received-Date: Thu, 03 Jan 2013 16:58:06 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jan 1, 2013 at 9:12 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> and started playing with chris larson's "bitbake-env" utility

Is there any chance of, or interest in, including "bitbake-env" in the
Yocto Project?


