Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web12.2303.1584760310587191917
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2020 20:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=gtQTBK/e;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: raj.khem@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id f20so6946011qtq.6;
        Fri, 20 Mar 2020 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K47224LoMX3Zl8DL2dWnfnnb2uk2A/1MfXdROdY7hw8=;
        b=gtQTBK/egVY9tmwbpItyfuhKt8/09KNu/If2w7j939bHxDAwE6K6ICu32ADzG0GMrC
         kNJzmoM08LDN21pUpjaPzd0CZs7tQ1ymZ6yEKaRopn4f8UFlGMB37ZLg6y6hoED5SzKV
         pg+36WZjhqkBUS1R4k6QJ7KtOXdq5lLkk34qHiaqrxawXcu6HfZQW94IMyB2ldmVUPQv
         JlumIeZEKqgTVMOBFyS/oaajSI5bONmwK6DX1kGeTCtB4YFCmZydqHsnhF92t4AdRwPV
         uLrSZfOz2MQLG/ULdA3W1MSrQLvY+1iIgdEAY9esMpZ7lQZ5Ij0Xn0aNkEYPjdxMgaK3
         STYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K47224LoMX3Zl8DL2dWnfnnb2uk2A/1MfXdROdY7hw8=;
        b=EwuuU994hIL04GAgsJYojpKeDtLPGjsSq53Fl97uGK1FlTquLQyLgdFv40T/oZkrPr
         Dv0XguC7G1r1ZHUR2qb/F7trqw+EkgIiY3MVXQkJAldz0ZspM3AEfkZ/IMrefTNx2vuz
         MS0rN1EttW8grg21ZO26I3jIIlk8p5Uf+HFNTlUD83QjWXeVYO9agNyG/H+ORReeGfId
         KHqNee/Xkxoy6/hOe5goFO/2vMXHNa0TKLYFJTsu/XtL33o/B7pnja1AcTeGaxI4IrjH
         RlVI3YTM2r4LsZa+9IHR+uKeDpAsCqk2HE6TuMSTew3m7PFV2ex/vDQsUqwIISWlCzDc
         MkKg==
X-Gm-Message-State: ANhLgQ2ltWCPth00tCUN3v4gYU338/CcC79COehz3hxyHWbICFD3gfxx
	v/l7tiBJWDMz7FtdJDD43xknjcgKCDp3YkXiUyQ=
X-Google-Smtp-Source: ADFU+vsoKtcZ/XRf+/r0yjiW/JAqVvUF9Rpk+wd8kB4O5yR2+E9r+9AQnPgW1DVrpst+zwRaTiPthZjtNLEa+Z//1Bk=
X-Received: by 2002:aed:3607:: with SMTP id e7mr11019307qtb.316.1584760309402;
 Fri, 20 Mar 2020 20:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <CADfgfobNNXr9HSOiwyamzbZ4q1uc8wgD5PzobDF56cDyYui-HQ@mail.gmail.com>
 <CADfgfoYCjVip=oc_U0TdFzOVst5U-KU+R31JhdckRv77APzQ-g@mail.gmail.com>
 <CADfgfob4=Zeh=jn9b9uMqq6Wnt83oGmJ-8yf1wSXYEFTppv2Bg@mail.gmail.com>
 <24a37655-8c0b-ca10-543e-90a32bc6bdb9@gmail.com> <CADfgfoZRZCM_Dvot5_z4YnG+OOyMg6xvDE13XQOK50wpucZWFA@mail.gmail.com>
In-Reply-To: <CADfgfoZRZCM_Dvot5_z4YnG+OOyMg6xvDE13XQOK50wpucZWFA@mail.gmail.com>
From: "Khem Raj" <raj.khem@gmail.com>
Date: Fri, 20 Mar 2020 20:11:38 -0700
Message-ID: <CAMKF1soxddFQ1Fx9ff8WPpywhZjNurAs1v7=daaCwfSFZ4BJmw@mail.gmail.com>
Subject: Re: [bitbake-devel] Mailing list platform change March 20th
To: Michael Halstead <mhalstead@linuxfoundation.org>
Cc: akuster808 <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org, 
	openembedded-architecture@lists.openembedded.org, 
	openembedded-core <openembedded-core@lists.openembedded.org>, 
	openembeded-devel <Openembedded-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000004bcfeb05a154c33f"

--0000000000004bcfeb05a154c33f
Content-Type: text/plain; charset="UTF-8"

Superb job Michael

On Fri, Mar 20, 2020 at 5:44 PM Michael Halstead <
mhalstead@linuxfoundation.org> wrote:

> The migration to Groups.io is nearly complete. All functionality is ready
> to use and you can send e-mail now. Archives are in place except for the
> most recent from the Openembedded-commits list. Those are continuing to
> import.
>
> There is no need to update your address book as the list addresses have
> not changed.
>
> If you encounter any issues please visit
> https://www.openembedded.org/wiki/GroupsMigration for the latest
> information. If your concern isn't addressed e-mail me directly.
>
> Thank you,
> --
> Michael Halstead
> Linux Foundation / Yocto Project
> Systems Operations Engineer
>
>
> On Fri, Mar 20, 2020 at 1:56 PM akuster808 <akuster808@gmail.com> wrote:
>
>> Micheal,
>>
>> Thanks for doing this.
>>
>> So just for my clarification, there is no needed to update any README to
>> use a different e-mail to like we did for the Yocto transitions since oe is
>> already using "lists.openembedded.org"
>>
>> - armin
>>
>
>>
>>
>> On 3/20/20 11:59 AM, Michael Halstead wrote:
>>
>> The migration will begin shortly. List mail will be delayed until the
>> process is complete. E-mail sent during downtime should eventually be
>> delivered. However waiting to send until after the switch is recommended.
>>
>> Thank you,
>> --
>> Michael Halstead
>> Linux Foundation / Yocto Project
>> Systems Operations Engineer
>>
>> On Thu, Mar 19, 2020 at 9:44 AM Michael Halstead <
>> mhalstead@linuxfoundation.org> wrote:
>>
>>> Everything is proceeding smoothly and this work will continue as
>>> planned. The migration starts at noon PDT tomorrow.
>>>
>>> List owners please take care of all outstanding moderation in the next
>>> 24 hours to ensure a smooth transition.
>>>
>>> Thank you,
>>> --
>>> Michael Halstead
>>> Linux Foundation / Yocto Project
>>> Systems Operations Engineer
>>>
>>> On Fri, Mar 13, 2020 at 4:58 PM Michael Halstead <
>>> mhalstead@linuxfoundation.org> wrote:
>>>
>>>> We are moving our lists from Mailman to Groups.io. E-mail to lists
>>>> will be delayed during the move window. We are aiming to complete the
>>>> migration during business hours in the Pacific time zone.
>>>>
>>>> A new account will be created for you on the Groups.io platform if you
>>>> don't already have one.
>>>>
>>>> You can read more about the change on the wiki:
>>>> https://www.openembedded.org/wiki/GroupsMigration
>>>>
>>>> If there are serious issues we will rollback the changes. We will e-mail
>>>> all lists when work is complete.
>>>>
>>>> --
>>>> Michael Halstead
>>>> Linux Foundation / Yocto Project
>>>> Systems Operations Engineer
>>>>
>>>>
>>
>> 
>
>

--0000000000004bcfeb05a154c33f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><div dir=3D"auto">Superb job Michael=C2=A0</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 2=
0, 2020 at 5:44 PM Michael Halstead &lt;<a href=3D"mailto:mhalstead@linuxfo=
undation.org">mhalstead@linuxfoundation.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div dir=3D"ltr">The migration to Groups.io is near=
ly complete. All functionality is ready to use and you can send e-mail=C2=
=A0now. Archives are in place except for the most recent from the Openembe=
dded-commits list. Those are continuing to import.<div><br></div><div>There=
 is no need to update your address book as the list addresses have not chan=
ged.=C2=A0</div><div><br></div><div>If you encounter=C2=A0any issues please=
 visit=C2=A0<a href=3D"https://www.openembedded.org/wiki/GroupsMigration" t=
arget=3D"_blank">https://www.openembedded.org/wiki/GroupsMigration</a>=C2=
=A0for the latest information. If your concern isn&#39;t addressed e-mail =
me directly.</div><div><br></div><div>Thank you,<br>--<br>Michael Halstead<=
br>Linux Foundation / Yocto Project<br>Systems Operations Engineer<br></div=
><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=
=3D"gmail_attr">On Fri, Mar 20, 2020 at 1:56 PM akuster808 &lt;<a href=3D"=
mailto:akuster808@gmail.com" target=3D"_blank">akuster808@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
  
    
  
  <div>
    Micheal,<br>
    <br>
    Thanks for doing this.<br>
    <br>
    So just for my clarification, there is no needed to update any
    README to use a different e-mail to like we did for the Yocto
    transitions since oe is already using &quot;<a href=3D"http://lists.op=
enembedded.org" target=3D"_blank">lists.openembedded.org</a>&quot;<br>
    <br>
    - armin</div></blockquote></div><div class=3D"gmail_quote"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div><br>
    <br>
    <br>
    <div>On 3/20/20 11:59 AM, Michael Halstead
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      
      <div dir=3D"ltr">The migration will begin shortly. List mail will be
        delayed until the process is complete. E-mail sent during
        downtime should eventually be delivered. However waiting to send
        until after the switch is recommended.
        <div><br>
        </div>
        <div>Thank you,<br>
          --<br>
          Michael Halstead<br>
          Linux Foundation / Yocto Project<br>
          Systems Operations Engineer<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 19, 2020 at 9:44
          AM Michael Halstead &lt;<a href=3D"mailto:mhalstead@linuxfoundat=
ion.org" target=3D"_blank">mhalstead@linuxfoundation.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir=3D"ltr">Everything is proceeding smoothly and this work
            will continue as planned. The migration starts at noon PDT
            tomorrow.
            <div><br>
            </div>
            <div>List owners please take care of all outstanding
              moderation in the next 24 hours to ensure a smooth
              transition.</div>
            <div><br>
            </div>
            <div>Thank you,</div>
            <div>--<br>
              Michael Halstead<br>
              Linux Foundation / Yocto Project<br>
              Systems Operations Engineer<br>
            </div>
          </div>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 13, 2020 at
              4:58 PM Michael Halstead &lt;<a href=3D"mailto:mhalstead@lin=
uxfoundation.org" target=3D"_blank">mhalstead@linuxfoundation.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div dir=3D"ltr">
                <div>We are moving our lists from Mailman to=C2=A0<span>Gr=
oups</span>.<span>io</span>.
                  E-mail to lists will be delayed during the move
                  window. We are aiming to complete the migration during
                  business hours in the Pacific time zone.<br>
                </div>
                <div><br>
                </div>
                <div>A new account will be created for you on the=C2=A0<sp=
an>Groups</span>.<span>io</span>=C2=A0platform
                  if you don&#39;t already have one.<br>
                </div>
                <div><br>
                </div>
                <div>You can read more about the change on the wiki:<br>
                </div>
                <a href=3D"https://www.openembedded.org/wiki/GroupsMigrati=
on" target=3D"_blank">https://www.openembedded.org/wiki/GroupsMigration</a>=
<br>
                <div><br>
                </div>
                <div>If there are serious issues we will rollback the
                  changes. We will e-mail<br>
                  all lists when work is complete.<br>
                </div>
                <div><br>
                </div>
                <div><span style=3D"color:rgb(136,136,136)">--</span><br s=
tyle=3D"color:rgb(136,136,136)">
                  <span style=3D"color:rgb(136,136,136)">Michael Halstead<=
/span><br style=3D"color:rgb(136,136,136)">
                  <span style=3D"color:rgb(136,136,136)">Linux Foundation
                    / Yocto Project</span><br style=3D"color:rgb(136,136,1=
36)">
                  <span style=3D"color:rgb(136,136,136)">Systems
                    Operations Engineer</span><br>
                </div>
                <div><br>
                </div>
              </div>
            </blockquote>
          </div>
        </blockquote>
      </div>
      <br>
      <fieldset></fieldset>
    </blockquote>
    <br>
  </div></blockquote></div><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div></div>

</blockquote></div>



<p></p><p></p></blockquote></div></div>

--0000000000004bcfeb05a154c33f--
