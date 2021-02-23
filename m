Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
 by mx.groups.io with SMTP id smtpd.web08.1.1614101083830006399
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Feb 2021 09:24:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=NvODqSdb;
 spf=pass (domain: gmail.com, ip: 209.85.217.48, mailfrom: christian.betz@gmail.com)
Received: by mail-vs1-f48.google.com with SMTP id g4so251907vsb.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Feb 2021 09:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QS5BmJJWVcOtPfhvWfq3oEavEbGkUESc+K7z+0jcm9Y=;
        b=NvODqSdbSwU5rvQqnXHeGPPmZtM05bcvzVbhCD4V+n2joZFaqEZ1822n7pm5jbHlGm
         A8/U25SRBsOGG3Rc5qWJjviZaY5F9oxVBTsqlL3q1cb3S+Mgg3Xy9JRzYPOia346hZdx
         v7L+FmdN4E4Sxgph2h37yjd/9QEMsBu2oCeIEN0B4jjmsiHFPr2hcQ8WaYQc0OHRySnR
         I4We6m67vuVfpmcsZ2GoXjOTr05zYSrzmsMo3YPQ9fJYrqjiUsz2koSULzlAIFBRoV+r
         axDmenh12DW8qjT8AYLgFLoFavMXq4YWrqYWtDHOHZWOX9pOliSSfa2LF4TqnsbcArI0
         tBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QS5BmJJWVcOtPfhvWfq3oEavEbGkUESc+K7z+0jcm9Y=;
        b=sfnQoz47+BK9eRUsBIk2aE0wmBObSrFd36yyDEelaAE9AqOLuXYs5Ei+q/RA7a3kjy
         4TXcc/ePdjF8mWG8o54nZZSoL/kSWP+rNHCMl8T6s7UNQ/B9kt7miwqMjRlrCGIxxGnl
         UntqBBOdepVj6VOf1pJgG4FFEuSjvmTlxAHLbJddSHfweMvaZknFgl1NwgX3B1pd7dZ8
         bCo5AlZReUQ56Nq45pjwaiNmC9wS7OPwSwJ3zfnyHYAYg882kV/W9PAy8PBX2iWqZreB
         oVXKvPt2ABu0YYyL8SCXYvoQtZnAcJbqI+IivchO8kaZV8SJTpkZbbOycTEBPqP0g/iz
         O0Qw==
X-Gm-Message-State: AOAM533HbNv9Fprjal9lm9O4WNJZuSWPfen/zriPqC1nQtqB6Ao6BhUP
	jl4JsNbPidHPHLYT8KjvUsYOJvQYvSO65N37z8fUSRq+dcc=
X-Google-Smtp-Source: ABdhPJzVI12fZnmr+/S24xqZUu4I2GcljnnA6efiRhgtuqRn9euWvQXWgT07/Vk3GaoZ5shE/x2Gnl7kKkWCQOPmsfA=
X-Received: by 2002:a67:69c7:: with SMTP id e190mr16944516vsc.20.1614101082615;
 Tue, 23 Feb 2021 09:24:42 -0800 (PST)
MIME-Version: 1.0
From: "Christian Betz" <christian.betz@gmail.com>
Date: Tue, 23 Feb 2021 12:24:31 -0500
Message-ID: <CAC9ffDEuZL-k8199bUyN+8frjw6bg-g=vrumxxtvt+RVParQ8Q@mail.gmail.com>
Subject: HTTP basic auth handling in wget.py and redirects
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000a9342c05bc0431de"

--000000000000a9342c05bc0431de
Content-Type: text/plain; charset="UTF-8"

hi everyone,

handling of user/pass (HTTP basic auth) in wget.py currently works like
this, by adding params to the wget CLI:

 fetchcmd += " --user=%s --password=%s --auth-no-challenge" % (ud.user,
ud.pswd)

my SRC_URI is something like "https://someuser:somepassword@bitbucket.org/...".


in this case we are authing against the bitbucket API using the
username/password. the initial request to bitbucket.org works fine.

however the actual download was failing due a redirect being followed to
what looks like a temporary, AWS-signed URL. AWS *rejects* the basic auth
and refuses the download.

i discovered that when using the --user and --pass params, wget will use
basic auth for the initial request AND all subsequent requests.

the good news is that wget is smart enough to pick up the
someuser/somepassword from the URI alone, and this does NOT cause redirects
to use basic auth!

(note: afaict this is undocumented behavior in wget.)

the "auth-no-challenge" seems to still be required, though. ultimately I
changed wget.py as follows:

 fetchcmd += " --auth-no-challenge"

i have patched our own wget.py for the time being. from a security point of
view, this also seems like the correct thing to do (it seems curl does NOT
include auth headers when following redirects, unless you ask for it).

however, this change would probably NOT work for anyone that *does* need
basic auth on the redirected request!

is the "correct" fix to add an additional fetcher option like
'authredirects'? would y'all take a patch for this feature?

christian

p.s. *in my opinion*, the --no-check-certificate in wget.py should be
turned off when using HTTP basic auth, since sensitive information may be
sent to an attacker-controlled host (in other cases i guess it is OK since
bitbake will verify checksums). i could try to make a patch for this too if
anyone agrees.

--000000000000a9342c05bc0431de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><table class=3D"gmail-diff-table gmail-js-diff-table gmail=
-tab-size gmail-file-diff-split gmail-js-file-diff-split"><tbody><tr><td cl=
ass=3D"gmail-code-review gmail-blob-code gmail-blob-code-addition"><span cl=
ass=3D"gmail-blob-code-inner gmail-blob-code-marker">        <span class=3D=
"gmail-pl-c">hi everyone,<br><br>handling of user/pass (HTTP basic auth) in=
 wget.py currently works like this, by adding params to the wget CLI:<br><b=
r>=C2=A0fetchcmd +=3D &quot; --user=3D%s --password=3D%s --auth-no-challeng=
e&quot; % (ud.user, ud.pswd)</span></span>

    </td>
</tr>




    <tr>
    </tr></tbody></table>
        <table class=3D"gmail-diff-table gmail-js-diff-table gmail-tab-size=
 gmail-file-diff-split gmail-js-file-diff-split"><tbody><tr><td class=3D"gm=
ail-code-review gmail-blob-code gmail-blob-code-context">

      <span class=3D"gmail-blob-code-inner gmail-blob-code-marker">        =
<span class=3D"gmail-pl-k"></span></span><br>my SRC_URI is something like &=
quot;<a href=3D"https://someuser:somepassword@bitbucket.org/..">https://som=
euser:somepassword@bitbucket.org/..</a>.&quot;. <br><br>in this case we are=
 authing against the bitbucket API using the username/password. the initial=
 request to <a href=3D"http://bitbucket.org">bitbucket.org</a> works fine.<=
/td></tr></tbody></table><div><br></div><div>however the actual download wa=
s failing due a redirect being followed to what looks like a temporary, AWS=
-signed URL. AWS *rejects* the basic auth and refuses the download.<br></di=
v><div><br></div><div>i discovered that when using the --user and --pass pa=
rams, wget will use basic auth for the initial request AND all subsequent r=
equests. <br></div><div><br></div><div>the good news is that wget is smart =
enough to pick up the someuser/somepassword from the URI alone, and this do=
es NOT cause redirects to use basic auth!<br></div><div><br></div><div>(not=
e: afaict this is undocumented behavior in wget.)</div><div><br></div><div>=
the &quot;auth-no-challenge&quot; seems to still be required, though. ultim=
ately I changed wget.py as follows:</div><div><br></div><div><span class=3D=
"gmail-blob-code-inner gmail-blob-code-marker"><span class=3D"gmail-pl-s1">=
=C2=A0fetchcmd</span> <span class=3D"gmail-pl-c1">+=3D</span> <span class=
=3D"gmail-pl-s">&quot; --auth-no-challenge&quot;</span></span></div><div><b=
r></div><div>i have patched our own wget.py for the time being. from a secu=
rity point of view, this also seems like the correct thing to do (it seems =
curl does NOT include auth headers when following redirects, unless you ask=
 for it). <br></div><div><br></div><div>however, this change would probably=
 NOT work for anyone that *does* need basic auth on the redirected request!=
<br></div><div><br></div><div>is the &quot;correct&quot; fix to add an addi=
tional fetcher option like &#39;authredirects&#39;? would y&#39;all take a =
patch for this feature?<br></div><div><br></div><div>christian<br></div><di=
v><br></div><div>p.s. *in my opinion*, the --no-check-certificate in wget.p=
y should be turned off when using HTTP basic auth, since sensitive informat=
ion may be sent to an attacker-controlled host (in other cases i guess it i=
s OK since bitbake will verify checksums). i could try to make a patch for =
this too if anyone agrees.<br></div><div><br></div><br></div>

--000000000000a9342c05bc0431de--
