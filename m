Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
	[209.85.223.179])
	by mail.openembedded.org (Postfix) with ESMTP id DACE4766F3
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Oct 2015 18:35:30 +0000 (UTC)
Received: by iofh134 with SMTP id h134so150774656iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 03 Oct 2015 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=UPGGbAdQtyQ/ASIvHoGU5+t39lHZusqRgkAY0qGheaY=;
	b=rPYPQ7WuoYu3y0d06+PxBnLFW6DEW8Vtx5dFeEA5h5CyjCeLYi7cKbMQhXqCSuLqwA
	OUKOskqx9KM87CGvGtX/rrMfjXS7cdFN3iTEywPZwOEDgsIWeD6mIZwK3NEdphnkpghW
	hUEXpgBE4p8rxk99zNy9ezh5lAo+QZn+aU8AEMC9A7SeSEfdguKELbxIAFtdEa0f2HOm
	wp9omg3xTZaaA+wKCENNNgXEm0bhXs53BYhjsYqZjXG7W1jKbeL5MdjBc6uJtriPylAi
	tRyK97BXRxVPoNtXxmtiuUUfm4dXV57K2/m+DMW3wquKERWwxycCA+GcMfKvlsWRwb9w
	raMQ==
X-Received: by 10.107.40.201 with SMTP id o192mr21600698ioo.83.1443897330954; 
	Sat, 03 Oct 2015 11:35:30 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Sat, 3 Oct 2015 11:35:11 -0700 (PDT)
In-Reply-To: <1443445902-32608-1-git-send-email-liu.ming50@gmail.com>
References: <1443445902-32608-1-git-send-email-liu.ming50@gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Sat, 3 Oct 2015 11:35:11 -0700
X-Google-Sender-Auth: Ah603y2TGJRvXotEy_rcSZKc7EQ
Message-ID: <CABcZANkWo=s5VDpO0nAs42q8Cv+sfhNeu7qsv+XBckEQFQZy7Q@mail.gmail.com>
To: Ming Liu <liu.ming50@gmail.com>
Cc: Peter Liu <peter.x.liu@external.atlascopco.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH] bitbake: fetch: Extend subdir unpack parameter to local folder
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
X-List-Received-Date: Sat, 03 Oct 2015 18:35:33 -0000
Content-Type: multipart/alternative; boundary=001a1141f41080f8fb0521378b4d

--001a1141f41080f8fb0521378b4d
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 28, 2015 at 6:11 AM, Ming Liu <liu.ming50@gmail.com> wrote:

> +                    if urldata.parm.get('subdir') != None:
> +                        destdir = urldata.parm.get('subdir') + "/" +
> destdir
>

If you really care about the difference between None and the empty string,
then this should be 'is not None', not '!= None', but most likely you
don't, in which case 'if urldata.parm.get('subdir')' is sufficient, and
cleaner. Also you do the parm.get() twice, it may be better to store that
in a variable.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1141f41080f8fb0521378b4d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Sep 28, 2015 at 6:11 AM, Ming Liu <span dir=3D"ltr">&lt;<a href=3D"=
mailto:liu.ming50@gmail.com" target=3D"_blank">liu.ming50@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":vt" class=3D"a=
3s" style=3D"overflow:hidden">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if urldata.parm.get(&#39;subdir&#39;) !=3D None=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 destdir =3D urldata.parm.get(&#39;subdir&#39;) + &quot;/&quot; +=
 destdir</div></blockquote></div><br>If you really care about the differenc=
e between None and the empty string, then this should be &#39;is not None&#=
39;, not &#39;!=3D None&#39;, but most likely you don&#39;t, in which case =
&#39;if urldata.parm.get(&#39;subdir&#39;)&#39; is sufficient, and cleaner.=
 Also you do the parm.get() twice, it may be better to store that in a vari=
able.<br>-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarso=
n at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Main=
tainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1141f41080f8fb0521378b4d--
