Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ABAC3DA7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 22:26:38 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.59463.1723501588018440518
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 15:26:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QYluDADM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36d2a601c31so2500351f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 15:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723501586; x=1724106386; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83jHCHkMyutGYcwRa7ZdsA12AbSE4ZbkQihkFBagxL4=;
        b=QYluDADMkT0sRktZ1FdvBmOFAMki+3kYWULiWoMvSUbG5Z5FX2goe8E4jX2KDJ0XIm
         p4XromOzR6GlIRAuqkR0NX3wH17LGZ3+YR8X2WXd5axpdvlWMO2h5UZlF2rrpuSNZwQu
         UvWj1de0Qenom1HUKRRj/pocUcBYAeG80TXgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723501586; x=1724106386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=83jHCHkMyutGYcwRa7ZdsA12AbSE4ZbkQihkFBagxL4=;
        b=udbviHEyFwXhMEqDYOTDGL7YHdXEe3ypjP7NSuWIjs+DF9ScWL2Ggt2Ci0ACToq5i3
         8FplkiZVivIXCTS+IlMOdpTzqMjSN4LbPFYNq3j2IvQYbGQ6WMJvghf/bDy3IumeA6on
         mg2d6Xhkr1eRZgeR5ySB9jgkj9AHDL/Xw/XVtyhZUj0BobqO34ZusWnLUSGaSR5GJjl3
         uHzKWf6yQVMMYjowrIjeo1vBfoI9p77Kaabtx3Lz9X+j8RSnOvnus3sj4uXXnVJfcJsI
         /sKipKCpvGSvsPIhY5/SVfy5YBlLf2cWuj2MQytpZR+lrVkQybbp79w9Ifqvu3ljHbNP
         rVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUfWtuYpoqzm+2eIGK+vcxg/HOgtbzRHyp4DjhwfPCpIRSfC4AwQz+qCikzxX4I925+WqPfLcM8UFL4cZwo@lists.openembedded.org
X-Gm-Message-State: AOJu0YyUmFRQ/Pccbunvxu0ofVDtLadOYLgVozVwGtY9Ng6Ft3lanznV
	qwjiy9IUT0zsI55qibPI5dOazSc45Cw24q3PdvVBm3TGp+SrV8glUkfxZ0513j4=
X-Google-Smtp-Source: AGHT+IG1noWDJyC3YiXsfvx9KmzP8Z7kOg4M/Mrv98ldkmqfJLEekkkQJqb13dqrYR5PmuWxfUReMA==
X-Received: by 2002:a5d:4812:0:b0:368:37d7:523f with SMTP id ffacd0b85a97d-3716ccd6ed2mr1307871f8f.13.1723501585979;
        Mon, 12 Aug 2024 15:26:25 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f56a:2899:1a73:e2fe? ([2001:8b0:aba:5f3c:f56a:2899:1a73:e2fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c938045sm8623777f8f.43.2024.08.12.15.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 15:26:25 -0700 (PDT)
Message-ID: <7274dd56985756ab2c2f088931d4b6c54e92f4df.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/4] BBHandler/ast: Improve addtask
 handling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 12 Aug 2024 23:26:24 +0100
In-Reply-To: <DB5PR02MB102134738BF9EC9D202B922CFEF852@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
	 <20240812155335.904273-3-richard.purdie@linuxfoundation.org>
	 <DB5PR02MB102134738BF9EC9D202B922CFEF852@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 22:26:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16477

On Mon, 2024-08-12 at 19:56 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel@lists.openembedded.org=C2=A0<bitbake-devel@lists.op=
enembedded.org> On Behalf Of Richard Purdie
> > Sent: den 12 augusti 2024 17:54
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH 3/4] BBHandler/ast: Improve addtask han=
dling
> >=20
> > The recent addtask improvement to handle comments complicated the regex=
 significantly
> > and there are already a number of corner cases in that code which aren'=
t handled well.
> >=20
> > Instead of trying to complicate the regex further, switch to code logic=
 instead. This
> > means the following cases are now handled:
> >=20
> > * addtask with multiple task names
> > * addtask with multiple before constraints
> > * addtask with multiple after constraints
> >=20
> > The testcase is updated to match the improvements.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0lib/bb/parse/ast.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26 +++++++-------------
> > =C2=A0lib/bb/parse/parse_py/BBHandler.py | 38 +++++++++++++++++--------=
-----
> > =C2=A0lib/bb/tests/parse.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++--------
> > =C2=A03 files changed, 35 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> > index 7581d003fd..001ba8d289 100644
> > --- a/lib/bb/parse/ast.py
> > +++ b/lib/bb/parse/ast.py
> > @@ -240,14 +240,16 @@ class ExportFuncsNode(AstNode):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 data.setVar(func, sentinel + "=C2=A0=C2=A0=C2=
=A0 " + calledfunc + "\n", parsing=3DTrue)
> >=20
> > =C2=A0class AddTaskNode(AstNode):
> > -=C2=A0=C2=A0=C2=A0 def __init__(self, filename, lineno, func, before, =
after):
> > +=C2=A0=C2=A0=C2=A0 def __init__(self, filename, lineno, tasks, before,=
 after):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AstNode.__init__(self,=
 filename, lineno)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.func =3D func
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.tasks =3D tasks
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.before =3D before
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.after =3D after
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 def eval(self, data):
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.build.addtask(self.func,=
 self.before, self.after, data)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tasks =3D self.tasks.split(=
)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for task in tasks:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.=
build.addtask(task, self.before, self.after, data)
> >=20
> > =C2=A0class DelTaskNode(AstNode):
> > =C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, filename, lineno, tasks):
> > @@ -348,21 +350,11 @@ def handlePythonMethod(statements, filename, line=
no, funcname, modulename, body)
> > =C2=A0def handleExportFuncs(statements, filename, lineno, m, classname)=
:
> > =C2=A0=C2=A0=C2=A0=C2=A0 statements.append(ExportFuncsNode(filename, li=
neno, m.group(1), classname))
> >=20
> > -def handleAddTask(statements, filename, lineno, m):
> > -=C2=A0=C2=A0=C2=A0 func =3D m.group("func")
> > -=C2=A0=C2=A0=C2=A0 before =3D m.group("before")
> > -=C2=A0=C2=A0=C2=A0 after =3D m.group("after")
> > -=C2=A0=C2=A0=C2=A0 if func is None:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
> > -
> > -=C2=A0=C2=A0=C2=A0 statements.append(AddTaskNode(filename, lineno, fun=
c, before, after))
> > -
> > -def handleDelTask(statements, filename, lineno, m):
> > -=C2=A0=C2=A0=C2=A0 func =3D m.group(1)
> > -=C2=A0=C2=A0=C2=A0 if func is None:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
> > +def handleAddTask(statements, filename, lineno, tasks, before, after):
> > +=C2=A0=C2=A0=C2=A0 statements.append(AddTaskNode(filename, lineno, tas=
ks, before, after))
> >=20
> > -=C2=A0=C2=A0=C2=A0 statements.append(DelTaskNode(filename, lineno, fun=
c))
> > +def handleDelTask(statements, filename, lineno, tasks):
> > +=C2=A0=C2=A0=C2=A0 statements.append(DelTaskNode(filename, lineno, tas=
ks))
> >=20
> > =C2=A0def handleBBHandlers(statements, filename, lineno, m):
> > =C2=A0=C2=A0=C2=A0=C2=A0 statements.append(BBHandlerNode(filename, line=
no, m.group(1)))
> > diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py=
/BBHandler.py
> > index c1653faeee..87c03e9238 100644
> > --- a/lib/bb/parse/parse_py/BBHandler.py
> > +++ b/lib/bb/parse/parse_py/BBHandler.py
> > @@ -23,7 +23,7 @@ __func_start_regexp__=C2=A0=C2=A0=C2=A0 =3D re.compil=
e(r"(((?P<py>python(?=3D(\s|\()))|(?P<fr>faker
> > =C2=A0__inherit_regexp__=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D re.com=
pile(r"inherit\s+(.+)" )
> > =C2=A0__inherit_def_regexp__=C2=A0=C2=A0 =3D re.compile(r"inherit_defer=
\s+(.+)" )
> > =C2=A0__export_func_regexp__=C2=A0=C2=A0 =3D re.compile(r"EXPORT_FUNCTI=
ONS\s+(.+)" )
> > -__addtask_regexp__=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D re.compile(=
r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>(([^#\n]*(?=3Dafter))|([^=
#\n]*))))|(after\s*(?P<after>(([^#\n]*(?=3Dbefore))|([^#\n]*)))))*(?P<comme=
nt>#.*|.*?)")
> > +__addtask_regexp__=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D re.compile(=
r"addtask\s+([^#\n]+)(?P<comment>#.*|.*?)")
> > =C2=A0__deltask_regexp__=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D re.com=
pile(r"deltask\s+([^#\n]+)(?P<comment>#.*|.*?)")
> > =C2=A0__addhandler_regexp__=C2=A0=C2=A0=C2=A0 =3D re.compile(r"addhandl=
er\s+(.+)" )
> > =C2=A0__def_regexp__=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D re.compile(r"def\s+(\w+).*:" )
> > @@ -239,29 +239,35 @@ def feeder(lineno, s, fn, root, statements, eof=
=3DFalse):
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 m =3D __addtask_regexp__.match(s)
> > =C2=A0=C2=A0=C2=A0=C2=A0 if m:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if len(m.group().split()) =
=3D=3D 2:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # C=
heck and warn for "addtask task1 task2"
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m2 =
=3D re.match(r"addtask\s+(?P<func>\w+)(?P<ignores>.*)", s)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
m2 and m2.group('ignores'):
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 logger.warning('addtask ignored: "%s"' % m2.group('ig=
nores'))
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check and warn for "addta=
sk task1 before task2 before task3", the
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # similar to "after"
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 taskexpression =3D s.split(=
)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for word in ('before', 'aft=
er'):
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
taskexpression.count(word) > 1:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 logger.warning("addtask contained multiple '%s' keywo=
rds, only one is supported" % word)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after =3D ""
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 before =3D ""
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tasks =3D m.group(1).split(=
" before ")[0].split(" after ")[0]
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for exp in m.group(1).split=
(" before "):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp=
2 =3D exp.split(" after ")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
len(exp2) > 1:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 after =3D after + " ".join(exp2[1:])
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for exp in m.group(1).split=
(" after "):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exp=
2 =3D exp.split(" before ")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
len(exp2) > 1:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 before =3D before + " ".join(exp2[1:])
>=20
> I found it hard to understand what the code above is actually doing.=20
> How about something like this instead (untested):
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur =3D "tasks"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tasks =3D {"tasks": [], "befor=
e": [], "after": []}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for task in m.group(1).split()=
:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if tas=
k in ("before", "after"):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cur =3D task
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # Check and warn for having a task with a keyword as par=
t of the task name
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if any(("%s_" % keyword) in task for keyword in bb.data_=
smart.__setvar_keyword__):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise ParseError("Task name '%s'=
 contains a keyword which is not recommended/supported.\nPlease rename the =
task not to include the keyword.\n%s" % (task, ("\n".join(map(str, bb.data_=
smart.__setvar_keyword__)))), fn)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tasks[cur].append(task)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if tasks["tasks"]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ast.ha=
ndleAddTask(statements, fn, lineno, tasks["tasks"], tasks["before"], tasks[=
"after"])
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return

This isn't entirely straightforward. I was trying to split only on
"before" and "after" and not on space characters. This leaves the
expansion and splitting as late as possible. I appreciate it still
isn't as late as it could be but it seemed to be a right step in the
direction of allowing expressions which deltask does but addtask does
not. The change brings them more into parity.

Cheers,

Richard



