Received: from mail-la0-f47.google.com ([209.85.215.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TSvme-0008C9-AQ
	for bitbake-devel@lists.openembedded.org;
	Mon, 29 Oct 2012 21:18:04 +0100
Received: by mail-la0-f47.google.com with SMTP id h5so3999472lam.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Oct 2012 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=C8ouM6/UPyeAhKmuANBL/Y7aw5BMM9dz/q6LtR+rLts=;
	b=vp765k3p5z7y7+fNG4YEVJ0KOfoKJy/KwNX8CYLEUxyUqEWkQ6b+7G1B4CwxkmzezA
	ufeExkR0qwgxE71mQ6sn1ojtwVIa65O/kcwv42Ar4khC1WHMSjoo6VuDxGjwUeqlvFqC
	F8NsQ9ijak2iLh8E5JBVl/D5Occ1ehX1oMf2oA0N1F8ZO4Gz8eo50JOYg8b3Y8mX8J31
	vnLFmr/rJRNeRbCqDI2lBg359HvIF5J3V0rIMI2M8vsk613kRs/DvGR44Qr/R6Qxs853
	VFt1DTT0cjTmm7fXEsk1Or9bkGBdT6Ktmz0cORVIxcFEoMNkecrMaY84jg5l96V0tAe7
	aJZg==
Received: by 10.112.24.6 with SMTP id q6mr12625615lbf.24.1351541069530; Mon,
	29 Oct 2012 13:04:29 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.1.49 with HTTP; Mon, 29 Oct 2012 13:04:09 -0700 (PDT)
In-Reply-To: <1351540883-10870-1-git-send-email-kergoth@gmail.com>
References: <1351540883-10870-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Mon, 29 Oct 2012 13:04:09 -0700
X-Google-Sender-Auth: h_nLwta3F0esaolP2Cc0EUmm0Rg
Message-ID: <CABcZAN=ftmG3BziBcWxiTgi43vqxKgzNPZ1ycB2rV=i-SiKHRg@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] command: add error to return of runCommand
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
X-List-Received-Date: Mon, 29 Oct 2012 20:18:04 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Oct 29, 2012 at 1:01 PM, Christopher Larson <kergoth@gmail.com> wrote:
> -        ret = server.runCommand(cmdline['action'])
> -        if ret != True:
> -            print("Couldn't get default commandline! %s" % ret)
> +        elif ret != True:
> +            logger.error("Command '%s' failed: returned %s" % (cmdline, ret))

I forgot that I left the print->logger.error and improved error
message in. That should probably have been a separate commit. Let me
know if that's a concern for anyone.

-Chris


