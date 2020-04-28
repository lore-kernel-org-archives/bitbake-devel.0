Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
 by mx.groups.io with SMTP id smtpd.web10.1002.1588097458183365273
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2020 11:10:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=oYlQ+Z41;
 spf=pass (domain: gmail.com, ip: 209.85.208.66, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f66.google.com with SMTP id s10so17140988edy.9;
        Tue, 28 Apr 2020 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQwzqE5uHcbqN5g1WDAzwZ97LhNcUaMpIQFIdJ7CPp0=;
        b=oYlQ+Z41QbjuAVuSbdSqcK5vJ1bv92pLbr2Ws7P6WpNydKAsF5FKNvS6WiyRRNrnI8
         6wJTPebjauvD9ry6gbOhWZIwXQXJm3OR5QD8sv5EHpnXbKsfwnzmI/OSbIsvc3eyl4PM
         TNYTC4jKoKJxHvWDWYbH5VX+RFm9kjXfWsKg6XCiNhfrFCVkTfcMvwRYNTKbYqUkMdLV
         FH9iT//Q8DMn6sD8ojQCLphWYOlosoQ4DMEc6V3gDg+FkIu1/qGV5Rm4/gnhGkX6Ya6r
         /nx3danscbejHi10CztWuI7w/EOs1bZN/I5mOXbPzp9s2gotPhf7IftueN0mYJIRjoBY
         hYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQwzqE5uHcbqN5g1WDAzwZ97LhNcUaMpIQFIdJ7CPp0=;
        b=YBY9XAc5JUr+Kx0lZlCZ2/y7+3nxkhxIKpdA7+yCTYt7HJGpBbBw0o+laKT7zYZshN
         YZxONQ1z/gj2nXSsPkYgO5s6psdKt52jcjpVzP0Jqgea3+d9ab5QtyBTkOrP9MAm2u0c
         HHWoJRiOhDNvcej8jDE1vY7C2db4zfmHVdwk5T3RQpqm7EJ6GXCHYijz4Dp9Lpm17+A+
         2fv1z1UShGrposBE+ul4ZzYIOCPrhDjhKfkWgce3+6nrKFswjpAPvRZsJlEQquwTK2AT
         eSo5bdncJeegumk5puu2UUAIgQlPDg5siqc/XqZ8+/l4n2zIxyKUXnDF8VSF9jqGXOrN
         3MWg==
X-Gm-Message-State: AGi0Pua/oQTUpH/bZIZk/HSI4gZ/XH7ypctVfnW/47Ot+s/v0V0dbS5F
	z7LQ9Cqbuonzlt0j+QLlvy2KHhBjKYoTfpiJ+jI=
X-Google-Smtp-Source: APiQypJLcCXUblnqEMxMfaBnr3W8a+U5ePcMwm/i/9jID76QSEBbbrV9/nTlh6B3QoYugrNBCba81mQRfxK/m32xqGE=
X-Received: by 2002:aa7:cdcb:: with SMTP id h11mr22696080edw.264.1588097456579;
 Tue, 28 Apr 2020 11:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <15FBEF1FC40D189D.8114@lists.yoctoproject.org> <81fb73b4-f683-5356-ff07-1ac909afb97d@gmail.com>
In-Reply-To: <81fb73b4-f683-5356-ff07-1ac909afb97d@gmail.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Tue, 28 Apr 2020 20:10:45 +0200
Message-ID: <CA+chaQc8q4Nb4p76WPr=R7ocpDJ8CY3VnJ-k9W8bWW8nwMtYTw@mail.gmail.com>
Subject: Re: [poky] Thud community support
To: akuster <akuster808@gmail.com>
Cc: Patches and discussions about the oe-core layer <openembedded-core@lists.openembedded.org>, 
	"yocto@yoctoproject.org" <yocto@yoctoproject.org>, "poky@yoctoproject.org" <poky@yoctoproject.org>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>, poky@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000c4aa0c05a45dc080"

--000000000000c4aa0c05a45dc080
Content-Type: text/plain; charset="UTF-8"

Is Thud EOL now?

Or did someone volunteer off-list and now it waits for Maintainer selection
process to be defined?

https://wiki.yoctoproject.org/wiki/Releases still says Community support.

Thanks

On Tue, Mar 17, 2020 at 10:13 PM akuster <akuster808@gmail.com> wrote:

>
>
> On 3/13/20 11:03 AM, akuster via Lists.Yoctoproject.Org wrote:
>
> The Poky thud branch is now under 'Community support' and is seeking a
> maintainer to continue supporting the following repos for the thud release:
>
> bitbake, core, meta-yocto and yocto-docs.
>
>
> There will be no more point releases.
>
> seehttps://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS#Maintainer_Procedures
> to get an idea on what is expected.
>
> The one thing we (YP) don't know is if there will be AutoBuilder
> resources available.  Please contact me or Richard regarding that statement.
>
> If no one steps up by April 24th (six weeks -ish from now), Thud will be
> moved to EOL status.
>
>
> It was pointed out to me that there is no Maintainer selection process or
> criteria defined.  This  will have to be sorted out before we move forward
> on this transition.
>
>
> - armin
>
> - Armin
>
>
>
>
>
>
> 
>

--000000000000c4aa0c05a45dc080
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is Thud EOL now?<div><br></div><div>Or did someone volunte=
er off-list and now it waits for Maintainer selection process to be defined=
?</div><div><br></div><div><a href=3D"https://wiki.yoctoproject.org/wiki/Re=
leases">https://wiki.yoctoproject.org/wiki/Releases</a>=C2=A0still says Com=
munity support.<br></div><div><br></div><div>Thanks</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 17, 20=
20 at 10:13 PM akuster &lt;<a href=3D"mailto:akuster808@gmail.com">akuster8=
08@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
  
    
  
  <div>
    <br>
    <br>
    <div>On 3/13/20 11:03 AM, akuster via
      <a href=3D"http://Lists.Yoctoproject.Org" target=3D"_blank">Lists.Yo=
ctoproject.Org</a> wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>The Poky thud branch is now under &#39;Community support&#39; a=
nd is seeking a
maintainer to continue supporting the following repos for the thud release=
:

bitbake, core, meta-yocto and yocto-docs.


There will be no more point releases.

see
<a href=3D"https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS#Maint=
ainer_Procedures" target=3D"_blank">https://wiki.yoctoproject.org/wiki/Stab=
le_Release_and_LTS#Maintainer_Procedures</a>=C2=A0
to get an idea on what is expected.

The one thing we (YP) don&#39;t know is if there will be AutoBuilder
resources available.=C2=A0 Please contact me or Richard regarding that sta=
tement.

If no one steps up by April 24th (six weeks -ish from now), Thud will be
moved to EOL status.
</pre>
    </blockquote>
    <br>
    It was pointed out to me that there is no Maintainer selection
    process or criteria defined.=C2=A0 This=C2=A0 will have to be sorted o=
ut
    before we move forward on this transition.<br>
    <br>
    <br>
    - armin<br>
    <br>
    <blockquote type=3D"cite">
      <pre>- Armin



</pre>
      <br>
      <fieldset></fieldset>
      <pre></pre>
    </blockquote>
    <br>
  </div>

<br>
</blockquote></div>

--000000000000c4aa0c05a45dc080--
