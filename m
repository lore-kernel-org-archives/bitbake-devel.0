Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1T1jL5-0006ob-Dr
	for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 21:33:11 +0200
Received: by lban1 with SMTP id n1so997328lba.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=o8qOCdJ6EMAD/pM0I+hnhGa5pDHsUvK9mKtKB0cx+cE=;
	b=v2FUr/GbL/ZxeVvueQZfINEh0xh4h+xbGdHIoW0MgQkOlS1eJXDid5UyuBclMZ/rKL
	R/2+5EUSoG9lzGXgd+Nz2P66ZAGkTMjAFfc+tWGSc9xQkjpbyGtA4zpkmbIxJGfwfFcO
	QNiyFugHCh/6zHy7xxVLdQjjrpo1ILjxnS9W8dG5Jq7BmyfEGhW4428oYMHwSjRdikYY
	oW4FqnwjiV934Qpr5XSkOu9rmuaFFm8NqsebbExfIIsxqR8R9PeeNHEAGpkA37S82DrI
	JnuWMEPxrtWiMYScMZAXiRMqtubtK8SVwpK2BbXwYDruHBwel5Wm+vlUkTzqR9QTCHxq
	mgwg==
Received: by 10.152.102.234 with SMTP id fr10mr17198829lab.32.1345058475062;
	Wed, 15 Aug 2012 12:21:15 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.114.5.104 with HTTP; Wed, 15 Aug 2012 12:20:54 -0700 (PDT)
In-Reply-To: <1345049422.14667.11.camel@ted>
References: <1345049422.14667.11.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 15 Aug 2012 12:20:54 -0700
X-Google-Sender-Auth: ixne6SO6P8t2imMW8Eeoe9_gSNA
Message-ID: <CABcZANmPSnoyQ4PDcEsE=4EErgpNekAG919Bj+-vFwqAq0BCmA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] knotty: Fold knotty2 into knotty and make it the default
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
X-List-Received-Date: Wed, 15 Aug 2012 19:33:11 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 15, 2012 at 9:50 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> There is no good reason knotty2 shouldn't be the default now. If you need
> the old behaviour, just pipe the output through cat as non-interactive
> terminals get the old output.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

I'm 100% in favor of this series, for what it's worth. I've been using
knotty2 as my default BITBAKE_UI for months, just ignoring the minor
bugs. The reduction in unnecessary output makes it *much* easier to
spot *real* problems.

That said, I think we should look into prefixing some of our log
messages =E2=80=94 some of them don't make it clear what task/recipe emitte=
d
them, making it difficult to isolate their cause. But of course, that
was an issue with knotty as well, but it was slightly easier to narrow
down the cause based on where it stood between the task
started/completed messages :). Would you be open to potentially
injecting a log message filter which adds task context informastion,
in the code which forks the tasks? Then the formatter would have to do
a hasattr() to check for that and add it to the format, but it'd mean
we *always* know what task log messages are coming from.
--=20
Christopher Larson


