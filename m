Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
 by mx.groups.io with SMTP id smtpd.web11.9826.1592656448893425818
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Jun 2020 05:34:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=bWseHgVR;
 spf=pass (domain: gmail.com, ip: 209.85.161.68, mailfrom: onea.alex@gmail.com)
Received: by mail-oo1-f68.google.com with SMTP id k7so2433612ooo.12
        for <bitbake-devel@lists.openembedded.org>; Sat, 20 Jun 2020 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WczwM+rQn+VPS1SQ4CzpXOlRWribtvpZmHSxuXxhFyg=;
        b=bWseHgVRWIg0p+wunQykfD/+x76vv5YYs2kuyisfJopo31O3HO6EOnDmZj6om+GrRs
         egipa326evTUZ9NyjOSHUXs/Juo7oVFKnmcCh3g1XMACmMEMzoP7O8j4vCPGmP/tUhLC
         35hUpw7YoMZvsgEeuIMbwjL0ag5mAvYbrp4ztSrDjA5TIU7iuFcjMJ9tB7Ovt0ofF6Qf
         4/r9kk+woFdmHLkio5OoSoPSV2W/TZtKGo1xBQhFrdEO5BPF43U9U2f/fHg8wQzDJoih
         7Oz16+065hZBkbXHKQTSj+ZxUh781KdBm5S6gpznkNIxf//kp4uayCgKtLH9lgQ1/3VA
         H1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WczwM+rQn+VPS1SQ4CzpXOlRWribtvpZmHSxuXxhFyg=;
        b=gsr7JJFtDbBs7PF7AErZeFTYRhhkpskJWZIaFRY25to9g9cLdj2KEsnEr+yh2U/u1Y
         A6pke3ArtafTeTIGAg0ON8p8TCBprpXpXnwsVkgl8MUA8w0QqYbIKNJ1iuc28TUGmy53
         7ogDlvj/huDDTPPB7kmCYYRTKG9J5AyScb6hfE/j9WydaFAFlfzDt+rLL93pYPhHygiI
         P7ccx4F1OuWrRdV19uYynYMfhw6T18wdiwiQ2w6RtGJB8EmCOgZrhOkyrBwHzorvwxui
         zlFRu4yED4MkkdJa+rxxl26+Qag4unPPNh2qF+UoQRlLBdDfqUe+pGR7WOhEVzi4MYaw
         blNg==
X-Gm-Message-State: AOAM532VqIsNwSGo1TRMGU/w4aws3hRt9i5z7ZfC1qbC0o3K3RIjMpXN
	3WqGd0Ufj0ATFqPVknbP6qiqrx3VBUE9T5YFpumo+RIjmJB6Fw==
X-Google-Smtp-Source: ABdhPJx2GaU43Mg1oMDcMDf/pOSWyctwBHEZg/epRsf7TCVDqAGQPSc1R3Kjp3W2ZIL63PcupqwU49wQlzY8NhdKL8E=
X-Received: by 2002:a4a:2412:: with SMTP id m18mr7218692oof.36.1592656447897;
 Sat, 20 Jun 2020 05:34:07 -0700 (PDT)
MIME-Version: 1.0
From: "Alexandru N. Onea" <onea.alex@gmail.com>
Date: Sat, 20 Jun 2020 15:33:57 +0300
Message-ID: <CAJgSc4zktj90d5DXXoSa8vE8=F58puwKD0YKUTMA0etGn3U=XQ@mail.gmail.com>
Subject: [fetcher2] perforce fetcher download dir
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d384f905a8833935"

--000000000000d384f905a8833935
Content-Type: text/plain; charset="UTF-8"

Hello community,

I just started using the perforce fetcher and I am a bit confused by how
the fetcher implementation handles the location of the downloaded sources.
In particular, in cases where SRC_URI points to a directory, expressed by
the typical "/..." termination, the below code seems to prepare the final
filename by only taking into account the part of the remote path which
would follow the "/...".

if depot_filename:
    if ud.pathisdir: # Remove leading path to obtain filename
        filename = depot_filename[len(ud.path)-1:]
    else:
        filename = depot_filename[depot_filename.rfind('/'):]
    filename = filename[:filename.find('#')] # Remove trailing '#rev'

This comes with a limitation: if one has multiple perforce SRC_URI entries,
one ends up with a mixture of files, not necessarily belonging together.
Moreover, the comment is a bit misleading, since the value of filename
after the removal of the leading path is not actually the filename but a
filepath, stripped of the "visible" repo path given in SRC_URI.

Of course, there might be a strong argument in favor of this behavior,
however I failed so far to find it. I am writing to you in the hope that
someone can help me find the argument and understand the rationale of the
current implementation.

If there is no argument in favor of the mentioned behavior, I would like to
prepare a patch for an alternative where the user has the option to either
keep the full remote file path (similar to how a perforce client would sync
the files) or strip the visible SRC_URI part of the path, but specify a
subdir name for each perforce SRC_URI entry in order to keep things
separated.

Thank you,
Alexandru Onea

--000000000000d384f905a8833935
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello community,<div><br></div><div>I just started using t=
he perforce fetcher and I am a bit confused by how the fetcher implementati=
on handles the location of the downloaded sources. In particular, in cases =
where SRC_URI points to a directory, expressed by the typical &quot;/...&qu=
ot; termination, the below code seems to prepare the final filename by only=
 taking into account the part of the remote path which would follow the &qu=
ot;/...&quot;.</div><div><br></div><div><table class=3D"gmail-highlight gma=
il-tab-size gmail-js-file-line-container" style=3D"border-spacing:0px;borde=
r-collapse:collapse;color:rgb(36,41,46);font-family:-apple-system,BlinkMacS=
ystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color=
 Emoji&quot;,&quot;Segoe UI Emoji&quot;;font-size:14px"><tbody style=3D"box=
-sizing:border-box"><tr style=3D"box-sizing:border-box"><td id=3D"gmail-LC9=
7" class=3D"gmail-blob-code gmail-blob-code-inner gmail-js-file-line" style=
=3D"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:=
top;overflow:visible">if depot_filename:<br>=C2=A0 =C2=A0 if ud.pathisdir: =
# Remove leading path to obtain filename<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fil=
ename =3D depot_filename[len(ud.path)-1:]<br>=C2=A0 =C2=A0 else:<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 filename =3D depot_filename[depot_filename.rfind(&#39;=
/&#39;):]<br>=C2=A0 =C2=A0 filename =3D filename[:filename.find(&#39;#&#39;=
)] # Remove trailing &#39;#rev&#39;<br></td></tr></tbody></table></div><div=
><br></div><div>This comes with a limitation: if one has multiple perforce =
SRC_URI entries, one ends up with a mixture of files, not necessarily=C2=A0=
belonging together. Moreover, the comment is a bit misleading, since the va=
lue of filename after the removal of the leading path is not actually the f=
ilename but a filepath, stripped of the &quot;visible&quot; repo path given=
 in SRC_URI.</div><div><br></div><div>Of course, there might be a strong ar=
gument in favor of this behavior, however I failed so far to find it. I am =
writing to you in the hope that someone can help me find the argument and u=
nderstand the rationale of the current implementation.</div><div><br></div>=
<div>If there is no argument in favor of the mentioned behavior, I would li=
ke to prepare a patch for an alternative where the user has the option to e=
ither keep the full remote file path (similar to how a perforce client woul=
d sync the files) or strip the visible SRC_URI part of the path, but specif=
y a subdir name for each perforce SRC_URI entry in order to keep things sep=
arated.=C2=A0</div><div><br></div><div>Thank you,<br clear=3D"all"><div><di=
v dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">=
<div dir=3D"ltr">Alexandru Onea</div></div></div></div></div>

--000000000000d384f905a8833935--
