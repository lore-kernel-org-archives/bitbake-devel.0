Return-Path: <kergoth@gmail.com>
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com
	[209.85.213.54])
	by mail.openembedded.org (Postfix) with ESMTP id C2D5475CF1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Sep 2015 21:23:05 +0000 (UTC)
Received: by vkhf67 with SMTP id f67so89035774vkh.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Sep 2015 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=EdLtkgW+6bdOcXhk4dlyrUoLRBkMvR9vylJ9vRLxTTI=;
	b=iESvEooZuz2Y8MWCvtR5BrbCZ/OF1UdbCrBZMNxnyGRXqavIU/cwrYq+v9LimJc1bM
	fEWq6cyN32/DMamsxKg73lvEFMXOtYV/WApxkIQlylNw5qiEcKltmqpqiDY8k113aMM6
	oAb+dtoHJysV9scs1Jw7PDQCu2h3nu0onDxbkuPiM+JvLiouhg/zOxwxoSbLdhVF2kvX
	DMoLG3Z98RUS8oQbZR4yBL0IP+G6QzSk+hjW0LVVyyJtB9vuq3gJynPpMz79gAada2wZ
	1Qr5RhQAgQd5Yo2RDEZrbzCSUD+yeQaRyX9jiEVPC/zPKUf4jmZnmM4c+tpr9lcRYB+6
	9jfA==
X-Received: by 10.31.5.205 with SMTP id 196mr23831796vkf.88.1442352185346;
	Tue, 15 Sep 2015 14:23:05 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.31.203.2 with HTTP; Tue, 15 Sep 2015 14:22:45 -0700 (PDT)
In-Reply-To: <1442352181-9304-1-git-send-email-kergoth@gmail.com>
References: <1442352181-9304-1-git-send-email-kergoth@gmail.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Tue, 15 Sep 2015 14:22:45 -0700
X-Google-Sender-Auth: aRrVrOWhj0BM7u4uoSTPU0tI3hA
Message-ID: <CABcZANkQjiPwSWgnZDUpvN0vitcLpdiE+HPWsmGtYrZhqMAwJg@mail.gmail.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCHv2] bb.fetch2.{git, hg}: remove tarball if it needs updating
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
X-List-Received-Date: Tue, 15 Sep 2015 21:23:06 -0000
Content-Type: multipart/alternative; boundary=001a1143dda0a611ca051fcfc93c

--001a1143dda0a611ca051fcfc93c
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 15, 2015 at 2:23 PM, Christopher Larson <kergoth@gmail.com>
wrote:

> From: Christopher Larson <chris_larson@mentor.com>
>
> We were maintaining state in the form of ud.repochanged to determine
> whether
> we need to write the tarball in the case where the tarball already exists,
> but
> this state is maintained only in memory. If we need to update the git repo,
> set ud.repochanged to True, and then are interrupted or killed, the tarball
> will then be out of date.
>
> Rather than maintaining this state, simply remove the out of date tarball
> when
> we update the git repo, and it will be re-created with updated content in
> build_mirror_data.
>
> [YOCTO #6366]
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>


Ignore the v2, only removing it when write_tarballs is set could be
problematic if the repo is updated with write_tarballs not set, then it's
set afterward.
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1143dda0a611ca051fcfc93c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Sep 15, 2015 at 2:23 PM, Christopher Larson <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kergoth@gmail.com" target=3D"_blank">kergoth@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">From:=
 Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor.com">chris_la=
rson@mentor.com</a>&gt;<br>
<br>
We were maintaining state in the form of ud.repochanged to determine whethe=
r<br>
we need to write the tarball in the case where the tarball already exists, =
but<br>
this state is maintained only in memory. If we need to update the git repo,=
<br>
set ud.repochanged to True, and then are interrupted or killed, the tarball=
<br>
will then be out of date.<br>
<br>
Rather than maintaining this state, simply remove the out of date tarball w=
hen<br>
we update the git repo, and it will be re-created with updated content in<b=
r>
build_mirror_data.<br>
<br>
[YOCTO #6366]<br>
<br>
Signed-off-by: Christopher Larson &lt;<a href=3D"mailto:chris_larson@mentor=
.com">chris_larson@mentor.com</a>&gt;</span></blockquote></div><br>Ignore t=
he v2, only removing it when write_tarballs is set could be problematic if =
the repo is updated with write_tarballs not set, then it&#39;s set afterwar=
d.<br>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">Christopher La=
rson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZa=
urus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</di=
v></div>
</div></div>

--001a1143dda0a611ca051fcfc93c--
