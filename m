Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
	[209.85.208.193])
	by mail.openembedded.org (Postfix) with ESMTP id 4A52B7DD69
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Jul 2019 21:12:10 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id t28so17366860lje.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Jul 2019 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=71m4yP1bqj7kTDmBiCBwb0Ss51TTThZZcVsn7dyTqao=;
	b=coPTgQ/i04Oo9snL+F6Gu/gra5Gk0SQf4t43O8DsJXMZ+nQ7Mbiw7i51DY66vK0L72
	veesMeqGiMweegQi+ElTXXnd96kOAx0+M+5kq8HI6gj8XX8aKRN/j8XNjqEt6MVp63Gt
	bwIse8PN1pGFihorjfbGS3xcyFvtdgiT5MmSftldlbvCZEZmscgXQ0ZJbNi1Rq/EAd8p
	CSyGFtrktTjqLncloQlT/qyARKnijNbh4tODIMy2ixaOVZ8FlbGQFyutqfV83KyyJS1/
	ywrgnOkhH8KoH6S7ICam0QiqpBgR/LM0LUxImWSrKCrbcuHBZCq9ra8KEEEsUL0oiYQN
	1I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=71m4yP1bqj7kTDmBiCBwb0Ss51TTThZZcVsn7dyTqao=;
	b=frfeeqq//ZGhlbzvkZIRfySh7eNRvi+DDUOXjc+H9l1Hf8RswRRuZwQJpUdjLGOMKh
	mmHhuadS1/jcmyc2ge4sEJLHm2eoYHSvcFxSVXoYfM2ZL5SZ83sunkhsD/lADD7cSUfe
	KNl8M2gSKCN3m6MucChjdtEz490P7yNgs5EI/pn5M1L/7NL1DEwQ9NQAIknCPsLwkLt2
	dO8NyXjy6UtSB6mDXLFUHsOQqS1WxXezXOGdLSezYlJ3Dpn0bzqHTztM2sdf0A14SvIg
	/x0W+qLfksoSYdsb6SXlBR7vLZBVM46QPjXi/J3rzy2T5YzNq3LRjLynl5X+eJiy6i86
	8AiA==
X-Gm-Message-State: APjAAAU+Cg/0Uxj3jbo90RLcxjpDps1y3EbWEdC3CH8AAPBJf7ETxZvf
	BxGlF+9NOY4HffR1sj4YAmSRw0/0jdeIfvhDE9I=
X-Google-Smtp-Source: APXvYqzuUxcIt9TWRt9u1Vb47paUH/bDvVCP/qXSjaxW1x7GtA/B2XrezkXrhz8+LOynsymACU1VY4tLdMsOa3b/LUg=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr11422378ljj.68.1562620330720; 
	Mon, 08 Jul 2019 14:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
In-Reply-To: <c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Tue, 9 Jul 2019 09:12:00 +1200
Message-ID: <CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
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
X-List-Received-Date: Mon, 08 Jul 2019 21:12:10 -0000
Content-Type: text/plain; charset="UTF-8"

We are using TFS in our company and within TFS we have different
project names that can have spaces.
With new version of TFS, git repo can also be created inside it and
the path of those repo also includes the project name that can have
space.
Hence the SRC_URI will have a space and that's when I started seeing errors.

Hope it answers your question

regards
Ankur

On Tue, Jul 9, 2019 at 6:28 AM Mark Hatle <mark.hatle@windriver.com> wrote:
>
> How is a space being added?  I'm a bit confused by this.  Is it due to the gitsm
> fetching?  or has someone figured out a way in SRC_URI to included spaces?
>
> If it's only in the gitsm fetching, then maybe we need to do the conversion
> there instead.
>
> --Mark
>
> On 7/3/19 11:46 PM, Ankur Tyagi wrote:
> > Signed-off-by: Ankur Tyagi <ankur.tyagi85@gmail.com>
> > ---
> >  lib/bb/fetch2/git.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 59a2ee8f..a8fcc2bf 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -156,6 +156,9 @@ class Git(FetchMethod):
> >          if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
> >              raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
> >
> > +        if ud.proto in ('http', 'https'):
> > +            ud.path = ud.path.replace(" ", "%20")
> > +
> >          ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
> >
> >          ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
> >
>

