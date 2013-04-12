Received: from mail-wg0-f44.google.com ([74.125.82.44])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <twoerner@gmail.com>)
	id 1UQkAh-0002vg-E1; Fri, 12 Apr 2013 22:02:08 +0200
Received: by mail-wg0-f44.google.com with SMTP id z11so3058991wgg.35
	for <multiple recipients>; Fri, 12 Apr 2013 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=LJ1bI0oMue5J5wE7ImU4854H+wHJAPMEw/9zvv1eNAc=;
	b=cGWcXLP6gVEtIW594hixJ2ZPHDUqI0InwRWiPtwJD+VT+6W8Qs0S6iV6vhYLBghYUS
	WFoC6QErZs+vK6Op7VUsFS4Jpt/Vb0KMvxm5JrlITpwr0DudsRYR+Tvp0szrDo0KXtdo
	w5zl5zc6gEND37IZrZ26PAFWe5azWH5WN59ZRHeuMmuK7OtBis9llQlIcuT0EuYi8v32
	BFksTQnDa2zCVPdrCcbqm3pa4ak41jYXLeij0RRDsTV3vy+D/ZyKKIe34XmFrF1/3Sm0
	+11POC+pPZEMUUlsuNHsmzwjw7TyHkmpX5C6cgenxg9HA0agRuXgIoRag4eoNa9vZGun
	pyWA==
MIME-Version: 1.0
X-Received: by 10.181.11.164 with SMTP id ej4mr6218040wid.29.1365795882100;
	Fri, 12 Apr 2013 12:44:42 -0700 (PDT)
Received: by 10.194.167.73 with HTTP; Fri, 12 Apr 2013 12:44:41 -0700 (PDT)
In-Reply-To: <20130411133031.GF2477@jama>
References: <20130411133031.GF2477@jama>
Date: Fri, 12 Apr 2013 15:44:41 -0400
Message-ID: <CAHUNapRzKJrofFbKX2=5rJZJxSdo+S+5c38GHkp0J8Mhz=C+sw@mail.gmail.com>
From: Trevor Woerner <twoerner@gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: Checksum failure encountered with download
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
X-List-Received-Date: Fri, 12 Apr 2013 20:02:16 -0000
Content-Type: text/plain; charset=ISO-8859-1

Sorry for not noticing this sooner.

On Thu, Apr 11, 2013 at 9:30 AM, Martin Jansa <martin.jansa@gmail.com> wrote:
> My proposal is to add md5sum of downloaded file to ChecksumError and
> rename it to <file>.<md5sum> in "if isinstance(e, ChecksumError):"

Would it be possible to make this behaviour configurable for those who
might be concerned about disk space? Or perhaps while renaming and
saving it, also move it into the $TMPDIR directory and/or tie this
feature in with rm_work?

I'm just thinking that over time one's DL_DIR could potentially become
rather cluttered with lots of failed downloads. Only some people would
be interested in seeing the failures and the rest would have to remove
them manually. I'm also thinking of the scenario where the DL_DIR is
shared/sync'ed among a group of people/computers; that could add up to
quite a bit of data to share.


