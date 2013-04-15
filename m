Received: from mail-lb0-f182.google.com ([209.85.217.182])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1URlvh-0003in-7t
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Apr 2013 18:07:14 +0200
Received: by mail-lb0-f182.google.com with SMTP id z13so4690150lbh.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Apr 2013 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=HGVIkTjy2vpJeGUdOs3lN1GC2DRosN+bY3wybxcNvpY=;
	b=yHjSSB05wP7UGbTSQtDjsjN6TTW+zmUi9XmVzoAbSDiLzD/f2CQvS8Bq5q/BeNmuN8
	R76nVWy89Y+e2QOLUz5iU/Eoc6LblYlDB55qXAMQebRUpOHJZ4xi8gYTRHoeU0oSVgl4
	/yc+zeVICllGOVfXwtFyCiNd5ZczX95WH7UL6ig/bL43so1w4JJsQSfB6v6GBitX++XT
	Ot9Eg4ziEdMeiTMG3eID6ku9SPwmrIlWz+qNZBggzKqpCNNFDO9G1kX3pvdZfEr4AvDF
	Blw6cw1+Y/pkfb9XKyzxTrtiXo7qvCQoq9IkpkzlsRY2AwGVpN5iHUPRMXKOLPFoTJXO
	Da9Q==
X-Received: by 10.112.139.7 with SMTP id qu7mr10574526lbb.13.1366040964134;
	Mon, 15 Apr 2013 08:49:24 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.125.38 with HTTP; Mon, 15 Apr 2013 08:49:04 -0700 (PDT)
In-Reply-To: <1366036054-12799-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1366036054-12799-1-git-send-email-paul.eggleton@linux.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 15 Apr 2013 08:49:04 -0700
X-Google-Sender-Auth: Xf84wgoa-rb8dNms5D1dvGxq-Y4
Message-ID: <CABcZANkEF+yoYqMD=dQ5oDPG2AfHK2-Fd9DVdGm5RraMS5N5sw@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] data: fix performance regression
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
X-List-Received-Date: Mon, 15 Apr 2013 16:07:29 -0000
Content-Type: multipart/alternative; boundary=089e0112bfa66a7de404da683216

--089e0112bfa66a7de404da683216
Content-Type: text/plain; charset=UTF-8

On Mon, Apr 15, 2013 at 7:27 AM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> BitBake commit 7c568132c54a21161de28907159f902462f1e2bb resulted in a
> fairly serious performance regression during parsing, almost doubling
> the time taken to do a full parse and almost certainly impacting
> performance during building. The expandKeys function is called
> frequently, and if we avoid using keys() and instead just use the normal
> variable lookup mechanism, performance is restored.
>
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
>

I would suggest using the existing __contains__ mechanism provided by
DataSmart.

    if newval in alterdata:

Should be sufficient, as MutableMapping from collections provides
__contains__ from Mapping, which in turn uses __getitem__.
-- 
Christopher Larson

--089e0112bfa66a7de404da683216
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Apr 15, 2013 at 7:27 AM, Paul Eggleton <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_blank">paul.eggleton@=
linux.intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1zw">BitBake commit 7c568132c54a=
21161de28907159f902462f1e2bb resulted in a<br>
fairly serious performance regression during parsing, almost doubling<br>
the time taken to do a full parse and almost certainly impacting<br>
performance during building. The expandKeys function is called<br>
frequently, and if we avoid using keys() and instead just use the normal<br=
>
variable lookup mechanism, performance is restored.<br>
<br>
Signed-off-by: Paul Eggleton &lt;<a href=3D"mailto:paul.eggleton@linux.inte=
l.com">paul.eggleton@linux.intel.com</a>&gt;</div></blockquote></div><br>I =
would suggest using the existing __contains__ mechanism provided by DataSma=
rt.</div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">=C2=A0 =C2=
=A0 if newval in alterdata:</div><div class=3D"gmail_extra"><br></div><div =
class=3D"gmail_extra">Should be sufficient, as MutableMapping from collecti=
ons provides __contains__ from Mapping, which in turn uses __getitem__.<br>

-- <br>Christopher Larson</div></div>

--089e0112bfa66a7de404da683216--
