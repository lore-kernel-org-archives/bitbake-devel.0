Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web10.215.1584751488596424480
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2020 17:44:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MX2TD+gt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.173, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-oi1-f173.google.com with SMTP id k21so8548051oij.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2020 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhIsmOx/CVLPS5UTRTLIx4WZA3Mz4hT3GALgHLarhbQ=;
        b=MX2TD+gtWzArreH18o46KKqBay5TS6qKWTa812gab788nQ6E1k76JmuU/b6YWZUCiL
         1iYK1gvAEy7uhvW8MykS1gTGlWoSreyk1h9llb4qo81GpIqokqwNy3caCRHzMJnejOtY
         XluNwbhQOxTFiu9n5Cq5MqiQABPVvrHTKJcNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhIsmOx/CVLPS5UTRTLIx4WZA3Mz4hT3GALgHLarhbQ=;
        b=lP61bg8HtPzvi85l1CUE9pLNP7lm4+ui+E2shc4cB9AGls0z756EDBZUwNIPXfKD4Y
         yuoxiIfxYhXVeAqsdWBnc1ce4PbN3AaAhJ3pIsDw+69xkVpfgdo1SDL2yIm/CO1BUXNo
         7U5yumfOVSKU/kfV+4bBI83Ds9QezRUwGOxrBKaRFqDp2ms9pgV1yUBgqZqFsAH5v6j7
         U9y85XBht26KEGHxNI8eFnFaEewlN1ou9dMFbQDI3YjPfLipOrwEUqWkxvnX8hhsXN5n
         Zgv3cOpWGEPOYwmsdCzyyO4dIgMTDiBJWdkZB48nKIWAG4I0xx1cCNESa5hTWqzaKG50
         fpLA==
X-Gm-Message-State: ANhLgQ1pSi0BOQwkM62JEChQ9zVpKd8PsJ1jY3ZWHhLme7nVHPJbzzsN
	UDJjn04TzpXkfJp0PYJanfQQRYP9hKQEm2tGJQ4EvQ==
X-Google-Smtp-Source: ADFU+vs4O/MRDzDP5Ap+++0sUe30Jd+OrZSshMtDkxVdmJTfQOcQY5ZhUemSSfVgqtU3k/zEiijs4OxAp/5v0oWB334=
X-Received: by 2002:aca:56c2:: with SMTP id k185mr8488826oib.141.1584751487835;
 Fri, 20 Mar 2020 17:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <CADfgfobNNXr9HSOiwyamzbZ4q1uc8wgD5PzobDF56cDyYui-HQ@mail.gmail.com>
 <CADfgfoYCjVip=oc_U0TdFzOVst5U-KU+R31JhdckRv77APzQ-g@mail.gmail.com>
 <CADfgfob4=Zeh=jn9b9uMqq6Wnt83oGmJ-8yf1wSXYEFTppv2Bg@mail.gmail.com> <24a37655-8c0b-ca10-543e-90a32bc6bdb9@gmail.com>
In-Reply-To: <24a37655-8c0b-ca10-543e-90a32bc6bdb9@gmail.com>
From: "Michael Halstead" <mhalstead@linuxfoundation.org>
Date: Fri, 20 Mar 2020 17:44:36 -0700
Message-ID: <CADfgfoZRZCM_Dvot5_z4YnG+OOyMg6xvDE13XQOK50wpucZWFA@mail.gmail.com>
Subject: Re: [bitbake-devel] Mailing list platform change March 20th
To: akuster808 <akuster808@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	openembedded-core <openembedded-core@lists.openembedded.org>, 
	openembedded-architecture@lists.openembedded.org, 
	openembeded-devel <Openembedded-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000007d715405a152b52d"

--0000000000007d715405a152b52d
Content-Type: text/plain; charset="UTF-8"

The migration to Groups.io is nearly complete. All functionality is ready
to use and you can send e-mail now. Archives are in place except for the
most recent from the Openembedded-commits list. Those are continuing to
import.

There is no need to update your address book as the list addresses have not
changed.

If you encounter any issues please visit
https://www.openembedded.org/wiki/GroupsMigration for the latest
information. If your concern isn't addressed e-mail me directly.

Thank you,
--
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer


On Fri, Mar 20, 2020 at 1:56 PM akuster808 <akuster808@gmail.com> wrote:

> Micheal,
>
> Thanks for doing this.
>
> So just for my clarification, there is no needed to update any README to
> use a different e-mail to like we did for the Yocto transitions since oe is
> already using "lists.openembedded.org"
>
> - armin
>
>
> On 3/20/20 11:59 AM, Michael Halstead wrote:
>
> The migration will begin shortly. List mail will be delayed until the
> process is complete. E-mail sent during downtime should eventually be
> delivered. However waiting to send until after the switch is recommended.
>
> Thank you,
> --
> Michael Halstead
> Linux Foundation / Yocto Project
> Systems Operations Engineer
>
> On Thu, Mar 19, 2020 at 9:44 AM Michael Halstead <
> mhalstead@linuxfoundation.org> wrote:
>
>> Everything is proceeding smoothly and this work will continue as planned.
>> The migration starts at noon PDT tomorrow.
>>
>> List owners please take care of all outstanding moderation in the next 24
>> hours to ensure a smooth transition.
>>
>> Thank you,
>> --
>> Michael Halstead
>> Linux Foundation / Yocto Project
>> Systems Operations Engineer
>>
>> On Fri, Mar 13, 2020 at 4:58 PM Michael Halstead <
>> mhalstead@linuxfoundation.org> wrote:
>>
>>> We are moving our lists from Mailman to Groups.io. E-mail to lists will
>>> be delayed during the move window. We are aiming to complete the migration
>>> during business hours in the Pacific time zone.
>>>
>>> A new account will be created for you on the Groups.io platform if you
>>> don't already have one.
>>>
>>> You can read more about the change on the wiki:
>>> https://www.openembedded.org/wiki/GroupsMigration
>>>
>>> If there are serious issues we will rollback the changes. We will e-mail
>>> all lists when work is complete.
>>>
>>> --
>>> Michael Halstead
>>> Linux Foundation / Yocto Project
>>> Systems Operations Engineer
>>>
>>>
>
>

--0000000000007d715405a152b52d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The migration to Groups.io is nearly complete. All functio=
nality is ready to use and you can send e-mail=C2=A0now. Archives are in pl=
ace except for the most recent from the Openembedded-commits list. Those ar=
e continuing to import.<div><br></div><div>There is no need to update your =
address book as the list addresses have not changed.=C2=A0</div><div><br></=
div><div>If you encounter=C2=A0any issues please visit=C2=A0<a href=3D"http=
s://www.openembedded.org/wiki/GroupsMigration">https://www.openembedded.org=
/wiki/GroupsMigration</a>=C2=A0for the latest information. If your concern =
isn&#39;t addressed e-mail me directly.</div><div><br></div><div>Thank you,=
<br>--<br>Michael Halstead<br>Linux Foundation / Yocto Project<br>Systems O=
perations Engineer<br></div><div><br></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2020 at 1:56 PM =
akuster808 &lt;<a href=3D"mailto:akuster808@gmail.com">akuster808@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Micheal,<br>
    <br>
    Thanks for doing this.<br>
    <br>
    So just for my clarification, there is no needed to update any
    README to use a different e-mail to like we did for the Yocto
    transitions since oe is already using &quot;<a href=3D"http://lists.ope=
nembedded.org" target=3D"_blank">lists.openembedded.org</a>&quot;<br>
    <br>
    - armin<br>
    <br>
    <br>
    <div>On 3/20/20 11:59 AM, Michael Halstead
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
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
          AM Michael Halstead &lt;<a href=3D"mailto:mhalstead@linuxfoundati=
on.org" target=3D"_blank">mhalstead@linuxfoundation.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
              4:58 PM Michael Halstead &lt;<a href=3D"mailto:mhalstead@linu=
xfoundation.org" target=3D"_blank">mhalstead@linuxfoundation.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div dir=3D"ltr">
                <div>We are moving our lists from Mailman to=C2=A0<span>Gro=
ups</span>.<span>io</span>.
                  E-mail to lists will be delayed during the move
                  window. We are aiming to complete the migration during
                  business hours in the Pacific time zone.<br>
                </div>
                <div><br>
                </div>
                <div>A new account will be created for you on the=C2=A0<spa=
n>Groups</span>.<span>io</span>=C2=A0platform
                  if you don&#39;t already have one.<br>
                </div>
                <div><br>
                </div>
                <div>You can read more about the change on the wiki:<br>
                </div>
                <a href=3D"https://www.openembedded.org/wiki/GroupsMigratio=
n" target=3D"_blank">https://www.openembedded.org/wiki/GroupsMigration</a><=
br>
                <div><br>
                </div>
                <div>If there are serious issues we will rollback the
                  changes. We will e-mail<br>
                  all lists when work is complete.<br>
                </div>
                <div><br>
                </div>
                <div><span style=3D"color:rgb(136,136,136)">--</span><br st=
yle=3D"color:rgb(136,136,136)">
                  <span style=3D"color:rgb(136,136,136)">Michael Halstead</=
span><br style=3D"color:rgb(136,136,136)">
                  <span style=3D"color:rgb(136,136,136)">Linux Foundation
                    / Yocto Project</span><br style=3D"color:rgb(136,136,13=
6)">
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
  </div>

</blockquote></div>

--0000000000007d715405a152b52d--
