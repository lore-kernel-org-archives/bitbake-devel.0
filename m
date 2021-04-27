Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web09.4928.1619506968416909426
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Apr 2021 00:02:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ducYGuNw;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: pgorszkowski@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id s9so9094861ljj.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Apr 2021 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iyCQKqUiWgmue+t770keSFf5ByHdg8HfY5Z6XnKQPu8=;
        b=ducYGuNwTkk7zUm4UomxuhHpKMbkwv3UZMtOOgqLiGbnIR0Bw9d+MfebvWRPsWIoxH
         RSgOi+nMZzj/UH0R5NXgF/9dUqdMzMCmQG8DmKWG16zDKnPz2hOEIx85/Vl2uvisdROn
         L54iQDNKQpyyFJB8UwPETTrPOBC3TrJRzpn5izsc5P7OkbNBADK+72kQPoH9iJN8kPMH
         dtg6V3840NY9kYQJ08cS8yXMiH4IIKyiKc+6ogAy3KL8spFcbXfeA0T5siktlAv/Fq9y
         83rxJ5bXJyzVNhSmABmqb1nlougiN89FiVKvz7inizbSx2/0dJNOnHjLsfBCqY9Gx9K5
         /69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iyCQKqUiWgmue+t770keSFf5ByHdg8HfY5Z6XnKQPu8=;
        b=c97Q3Xpk3uw+Q7QXyJXKjsfD1ca18EKlbRrRWO3r8xJbLcBXRQKY2t/Jls33XiXYiW
         w+ijTEufsWrW3uYvu3YLLx9CXld2LvpLJNdzjTHZ/HiUti3pIeRFiuYLQWDu7hPL01bK
         6HE7WAjqafusKK31df708CAkvXgKAfzUI8Dy+thai6p6NSCtP89suOOtrHCZ7m2UpJgY
         N43ZS7csSyk6Xa96jMXDqLrIFoxmyLhqfS/j++HJKv+0OqjUSQhp+M6ZSYsC+7/xad/a
         PKwSNimdoiN5UyQtwXyigQNkVfohoVj1NcA454I1OH7J2uFM+PCg6JkCrFbafIoeb5w7
         q9zA==
X-Gm-Message-State: AOAM530HF6LsevPfD5zNciro07eLWg5+ECfIiQapzxjzLTnzDbHJoRfR
	8xVhc619h3PxwP0wLRTPNaes5L/r6bPjZgNgec6cSESguq0RNw==
X-Google-Smtp-Source: ABdhPJyRLfBYzMcEQMGTT7rdh7axkQLdPsIP3c4bACAGTN/JAmYXY3Ws516uFhWut2r/DfU/lxMmgZ2AwcmeJILV44k=
X-Received: by 2002:a2e:8144:: with SMTP id t4mr15625046ljg.357.1619506966316;
 Tue, 27 Apr 2021 00:02:46 -0700 (PDT)
MIME-Version: 1.0
From: pgorszkowski@gmail.com
Date: Tue, 27 Apr 2021 09:02:35 +0200
Message-ID: <CAExyXVSe-0nJL3XTTXzG2DQ65KVBzOOyMvpFzB357P7ykU7HdA@mail.gmail.com>
Subject: [PATCH] S3 fetcher: add progress handler for S3 cp command
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000704af505c0eed9ac"

--000000000000704af505c0eed9ac
Content-Type: text/plain; charset="UTF-8"

Hi,

This is my first patch here so forgive me if I am doing it wrong.

Regarding to my patch:
In case of fetching source from the AWS there is no progress available.
This change provides a progress by extracting the needed values from logs
of the aws-cli cp command.
-- 
Best regards/Pozdrawiam

Przemyslaw Gorszkowski

--000000000000704af505c0eed9ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><font style=3D"font-family:Calibri,Helvetica,sans-ser=
if,serif,&quot;EmojiFont&quot;" size=3D"3" face=3D"Calibri,Helvetica,sans-s=
erif" color=3D"black"><span style=3D"font-size:12pt" id=3D"gmail-divtagdefa=
ultwrapper">Hi,</span></font></div><div><font style=3D"font-family:Calibri,=
Helvetica,sans-serif,serif,&quot;EmojiFont&quot;" size=3D"3" face=3D"Calibr=
i,Helvetica,sans-serif" color=3D"black"><span style=3D"font-size:12pt" id=
=3D"gmail-divtagdefaultwrapper"><br></span></font></div><div><font style=3D=
"font-family:Calibri,Helvetica,sans-serif,serif,&quot;EmojiFont&quot;" size=
=3D"3" face=3D"Calibri,Helvetica,sans-serif" color=3D"black"><span style=3D=
"font-size:12pt" id=3D"gmail-divtagdefaultwrapper">This is my first patch h=
ere so forgive me if I am doing it wrong.</span></font></div><div><font sty=
le=3D"font-family:Calibri,Helvetica,sans-serif,serif,&quot;EmojiFont&quot;"=
 size=3D"3" face=3D"Calibri,Helvetica,sans-serif" color=3D"black"><span sty=
le=3D"font-size:12pt" id=3D"gmail-divtagdefaultwrapper"><br></span></font><=
/div><div><font style=3D"font-family:Calibri,Helvetica,sans-serif,serif,&qu=
ot;EmojiFont&quot;" size=3D"3" face=3D"Calibri,Helvetica,sans-serif" color=
=3D"black"><span style=3D"font-size:12pt" id=3D"gmail-divtagdefaultwrapper"=
>Regarding to my patch:<br></span></font></div><div><font style=3D"font-fam=
ily:Calibri,Helvetica,sans-serif,serif,&quot;EmojiFont&quot;" size=3D"3" fa=
ce=3D"Calibri,Helvetica,sans-serif" color=3D"black"><span style=3D"font-siz=
e:12pt" id=3D"gmail-divtagdefaultwrapper">In
 case of fetching source from the AWS there is no progress available.=20
This change provides a progress by extracting the needed values from logs o=
f the aws-cli cp command.</span></font><br></div>-- <br><div dir=3D"ltr" cl=
ass=3D"gmail_signature" data-smartmail=3D"gmail_signature">Best regards/Poz=
drawiam<br><br>Przemyslaw Gorszkowski</div></div>

--000000000000704af505c0eed9ac--
