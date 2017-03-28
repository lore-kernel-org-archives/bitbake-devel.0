Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
	[209.85.218.54])
	by mail.openembedded.org (Postfix) with ESMTP id 4725771C9A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 16:01:50 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id r203so42167089oib.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=hKWljFVxz9AlBxd2TLwAuMUiAmdO8cp6MN/ajt4PwIE=;
	b=vO2MPy5ONLHW9K2xbAaTLLFbzSH4SKZ3mt/ozTW5Qavk2zx0K5etiLcqBrbU106E+1
	K9ymhanYvyjlz/TG4u4EPDoYNE6yrr13Cyya7WuhSDQV9ZfXmBWzcLbW7rUJSqBlPQKA
	a1xfn37rjF+SugFYfl3gPJcmPZ8fl4mZdh9p07f7Otgt5doClvAwYC2tg7h1GJxy98WN
	pIZpETk+bKlE0/UZ0dOzYwnB4i8cSVhmMXJ2pjp3IRK2FBuM984UJ0A0KREdlcIJWR5w
	HhO/U0b7yjVh17cMgqpAWJxCdadWj31BFwk2tm7DTNcayQvAVA44wa35sdEasEoxpFBE
	4KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=hKWljFVxz9AlBxd2TLwAuMUiAmdO8cp6MN/ajt4PwIE=;
	b=snit+KzQI0BsEi+RVhaYA7Vuepj9haIL274/ZeDyhb2cUxGZLNLEoNYhCGcoQR3RT6
	w9WuN32wH3eOcvpKMdk5UZqQysUK9VNKAVVo1Z+OLpLydsbTL+4Lcmn4uyRaBFSe9QjY
	zdSBihXtFDVdwOg5w2Tni3wkGnbP1DljTMVcGk/P+l8Xz1VOdgBhilCcUYViEYhiUUch
	a7G6xiPMmmu0bRaTkhJvkEmakHLIZEJiCGuGDJJzYUreSVxyq/YoqgawnL6yvXjDjtGf
	w/sEDZedc8lak4dZFNVtV1FajYSAy+m1RU5q1PD0eQoFBA5kXkJyIH7RNtm+qO0XvZ+H
	po1w==
X-Gm-Message-State: AFeK/H3BhphC9A8GaVW5zUxfvJzcfFFYj4OY3FQ3oDnH8VhhFv3B9hlalbXlASUAYmjDVWm48JDn6hHYS04b3Q==
X-Received: by 10.202.237.65 with SMTP id l62mr6814185oih.38.1490716912122;
	Tue, 28 Mar 2017 09:01:52 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.32.161 with HTTP; Tue, 28 Mar 2017 09:01:31 -0700 (PDT)
In-Reply-To: <93968aed34753e90e05945b2bce34ccfb4743a60.1490662146.git.paul.eggleton@linux.intel.com>
References: <cover.1490662146.git.paul.eggleton@linux.intel.com>
	<93968aed34753e90e05945b2bce34ccfb4743a60.1490662146.git.paul.eggleton@linux.intel.com>
From: Christopher Larson <chris_larson@mentor.com>
Date: Tue, 28 Mar 2017 09:01:31 -0700
X-Google-Sender-Auth: qrBNYxZG-GO--tCm31hB5hBKrrE
Message-ID: <CABcZANnahbPL5bLobQ8TTQu=+UmdyHpmi8u7wbduZFSkcQzBgQ@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] lib/bb/codeparser: ensure BufferedLogger respects target filtering
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
X-List-Received-Date: Tue, 28 Mar 2017 16:01:53 -0000
Content-Type: multipart/alternative; boundary=001a113d24240203a3054bcc949d

--001a113d24240203a3054bcc949d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 5:51 PM, Paul Eggleton <
paul.eggleton@linux.intel.com> wrote:

> BufferedLogger was sending log records to the target logger using
> handle() - this meant that the filtering (e.g. log level set)
> on the target logger was bypassed, leading for example to debug records
> getting printed when the log level was set to logging.WARNING.
>
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>


The =E2=80=98filter=E2=80=99 method of a Logger instance doesn=E2=80=99t lo=
g anything, it=E2=80=99s a
subclass of Filterer, which just checks whether it should be logged. The
=E2=80=98handle=E2=80=99 method of a Logger already consults self.filter(),=
 if you check
the code:

   def handle(self, record):
          """
          Call the handlers for the specified record.

          This method is used for unpickled records received from a socket,
as
          well as those created locally. Logger-level filtering is applied.
          """
          if (not self.disabled) and self.filter(record):
              self.callHandlers(record)
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a113d24240203a3054bcc949d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Mon, Mar 27, 2017 at 5:51 PM, Paul Eggleton <span dir=
=3D"ltr">&lt;<a href=3D"mailto:paul.eggleton@linux.intel.com" target=3D"_bl=
ank">paul.eggleton@linux.intel.com</a>&gt;</span> wrote:<br><div class=3D"g=
mail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb=
(204,204,204);border-left-style:solid;padding-left:1ex">BufferedLogger was =
sending log records to the target logger using<br>
handle() - this meant that the filtering (e.g. log level set)<br>
on the target logger was bypassed, leading for example to debug records<br>
getting printed when the log level was set to logging.WARNING.<br>
<br>
Signed-off-by: Paul Eggleton &lt;<a href=3D"mailto:paul.eggleton@linux.inte=
l.com">paul.eggleton@linux.intel.com</a><wbr>&gt;</blockquote><div><br></di=
v><div>The =E2=80=98filter=E2=80=99 method of a Logger instance doesn=E2=80=
=99t log anything, it=E2=80=99s a subclass of Filterer, which just checks w=
hether it should be logged. The =E2=80=98handle=E2=80=99 method of a Logger=
 already consults self.filter(), if you check the code:</div><div><div><br>=
</div><div>=C2=A0 =C2=A0def handle(self, record):</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Call the handlers for the specified record.</div><div><br></div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This method is used for unpickled r=
ecords received from a socket, as</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 well as those created locally. Logger-level filtering is applied.</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (not self.disabled) and self.filter(record)=
:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.callHandl=
ers(record)</div></div></div>-- <br><div class=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Christopher Larso=
n<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZauru=
s<br>Senior Software Engineer, Mentor Graphics</div></div></div></div></div=
></div></div>
</div></div>

--001a113d24240203a3054bcc949d--
