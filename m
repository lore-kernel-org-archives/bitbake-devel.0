Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.2618.1588172003734716868
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2020 07:53:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=LPk1r2W+;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: akuster808@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id f8so924615plt.2;
        Wed, 29 Apr 2020 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=2RuV1L/3XvCiRbtORxc8zZvktnSaBZ0CgHrnyIimmNM=;
        b=LPk1r2W+uCWybVrXd/dSkJGKaLbOdeukURnrVaahRyOp+cd6fpY2MojHHuYbrg+cgk
         CDRDWaVe7CbTXa6FLeeVje/w/GICqAaI5Jul/5U7spe3T1zjd9lnpBUmJs2MCxa2M68W
         ZzvkELaRiLgw8sp0g+tLnfGW6iWVIQeZla8zwxVpoLg6VNDd76c/0Xh4oN+BpYu3fX6H
         iL3T35nTkI5toQeCrt6YexrYqxKMNvKPJ7nELSNDlY7RmFqNK13uQTLVXhxV6LI/N4mJ
         I16KaLjLMk5V66KAsx7KddjOgshiGZO067q12M/ipTUVIiS6mGU8p6wqUTFK9EKq4h4q
         posg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=2RuV1L/3XvCiRbtORxc8zZvktnSaBZ0CgHrnyIimmNM=;
        b=SSGwo/Otn9P5di1C/gTXkQAbGaaPqty4kLu00DrFi7JUhkEbmChPdEG2VD8a0VIz6c
         bjXLOkI+AmZYaCfEFyLbain43lFRrqwkXFW1c2mIiT+gwca/L6eWvT3id2CowyvDDvKo
         x5GZig01lisQH4i1U96HBf2dfep5cwRGYa0cJH4JTBBKE64r1412Enf/93hGtFAprmId
         zKRzGX9gtFHfosLDRApvFPIJVujMAzdJyWd7Mbi2BpuVataVLtfjGqk4UvbzLOs6JeQC
         OIfBDceXR5tMGesfRhdi3OL9RMQU9mCKEWdRBfmQXax//9oBLQVRY1jqLRCQtRFeWC6H
         dQPw==
X-Gm-Message-State: AGi0PuYu7tATrX16FOb3OaJjdi3Fldz5shg+6OrzSqtuQa9kMNvS8T3Y
	+wmuAjEWEuvmWSPgjk84izI=
X-Google-Smtp-Source: APiQypI+8W1KlGvH+VxRbdG7E/r/9PdQJ+YoQ5lFauYpV1OkmAuuUIj6Lci3XeC8BsdxcUZ1sMqEpg==
X-Received: by 2002:a17:90a:77c6:: with SMTP id e6mr3794392pjs.84.1588172002940;
        Wed, 29 Apr 2020 07:53:22 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from ?IPv6:2601:202:4180:a5c0:3c5d:7c09:562a:defe? ([2601:202:4180:a5c0:3c5d:7c09:562a:defe])
        by smtp.gmail.com with ESMTPSA id j13sm4973706pje.1.2020.04.29.07.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 07:53:22 -0700 (PDT)
Subject: Re: [bitbake-devel] [poky] Thud community support
To: Martin Jansa <Martin.Jansa@gmail.com>, akuster <akuster808@gmail.com>
Cc: Patches and discussions about the oe-core layer
 <openembedded-core@lists.openembedded.org>,
 "yocto@yoctoproject.org" <yocto@yoctoproject.org>,
 "poky@yoctoproject.org" <poky@yoctoproject.org>,
 "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, poky@lists.yoctoproject.org
References: <15FBEF1FC40D189D.8114@lists.yoctoproject.org>
 <81fb73b4-f683-5356-ff07-1ac909afb97d@gmail.com>
 <CA+chaQc8q4Nb4p76WPr=R7ocpDJ8CY3VnJ-k9W8bWW8nwMtYTw@mail.gmail.com>
From: "akuster" <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
 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
 8CS2NxU=
Message-ID: <dc37c701-80de-6719-8d8b-6d8dcd1771f4@gmail.com>
Date: Wed, 29 Apr 2020 07:53:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CA+chaQc8q4Nb4p76WPr=R7ocpDJ8CY3VnJ-k9W8bWW8nwMtYTw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------C2905E87FB9E46D7559EF363"
Content-Language: en-US

--------------C2905E87FB9E46D7559EF363
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 4/28/20 11:10 AM, Martin Jansa wrote:
> Is Thud EOL now?
Go question.

>
> Or did someone volunteer off-list and now it waits for Maintainer
> selection process to be defined?
I received two inquires privately and forwarded them to Richard. I have
not had time to document the community maintainer selection process. The
ultimate decision will always be on the Repo maintainer which in this
case is Richard.

- armin

> https://wiki.yoctoproject.org/wiki/Releases still says Community support.
>
> Thanks
>
> On Tue, Mar 17, 2020 at 10:13 PM akuster <akuster808@gmail.com
> <mailto:akuster808@gmail.com>> wrote:
>
>
>
>     On 3/13/20 11:03 AM, akuster via Lists.Yoctoproject.Org
>     <http://Lists.Yoctoproject.Org> wrote:
>>     The Poky thud branch is now under 'Community support' and is seeking a
>>     maintainer to continue supporting the following repos for the thud release:
>>
>>     bitbake, core, meta-yocto and yocto-docs.
>>
>>
>>     There will be no more point releases.
>>
>>     see
>>     https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS#Maintainer_Procedures 
>>     to get an idea on what is expected.
>>
>>     The one thing we (YP) don't know is if there will be AutoBuilder
>>     resources available.  Please contact me or Richard regarding that statement.
>>
>>     If no one steps up by April 24th (six weeks -ish from now), Thud will be
>>     moved to EOL status.
>
>     It was pointed out to me that there is no Maintainer selection
>     process or criteria defined.  This  will have to be sorted out
>     before we move forward on this transition.
>
>
>     - armin
>
>>     - Armin
>>
>>
>>
>>
>
>
>
> 


--------------C2905E87FB9E46D7559EF363
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 4/28/20 11:10 AM, Martin Jansa
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+chaQc8q4Nb4p76WPr=R7ocpDJ8CY3VnJ-k9W8bWW8nwMtYTw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">Is Thud EOL now?</div>
    </blockquote>
    Go question.<br>
    <br>
    <blockquote type="cite"
cite="mid:CA+chaQc8q4Nb4p76WPr=R7ocpDJ8CY3VnJ-k9W8bWW8nwMtYTw@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>Or did someone volunteer off-list and now it waits for
          Maintainer selection process to be defined?</div>
      </div>
    </blockquote>
    I received two inquires privately and forwarded them to Richard. I
    have not had time to document the community maintainer selection
    process. The ultimate decision will always be on the Repo maintainer
    which in this case is Richard.<br>
    <br>
    - armin<br>
    <br>
    <blockquote type="cite"
cite="mid:CA+chaQc8q4Nb4p76WPr=R7ocpDJ8CY3VnJ-k9W8bWW8nwMtYTw@mail.gmail.com">
      <div dir="ltr">
        <div><a href="https://wiki.yoctoproject.org/wiki/Releases"
            moz-do-not-send="true">https://wiki.yoctoproject.org/wiki/Releases</a> still
          says Community support.<br>
        </div>
        <div><br>
        </div>
        <div>Thanks</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, Mar 17, 2020 at 10:13
          PM akuster &lt;<a href="mailto:akuster808@gmail.com"
            moz-do-not-send="true">akuster808@gmail.com</a>&gt; wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> <br>
            <br>
            <div>On 3/13/20 11:03 AM, akuster via <a
                href="http://Lists.Yoctoproject.Org" target="_blank"
                moz-do-not-send="true">Lists.Yoctoproject.Org</a> wrote:<br>
            </div>
            <blockquote type="cite">
              <pre>The Poky thud branch is now under 'Community support' and is seeking a
maintainer to continue supporting the following repos for the thud release:

bitbake, core, meta-yocto and yocto-docs.


There will be no more point releases.

see
<a href="https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS#Maintainer_Procedures" target="_blank" moz-do-not-send="true">https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS#Maintainer_Procedures</a> 
to get an idea on what is expected.

The one thing we (YP) don't know is if there will be AutoBuilder
resources available.  Please contact me or Richard regarding that statement.

If no one steps up by April 24th (six weeks -ish from now), Thud will be
moved to EOL status.
</pre>
            </blockquote>
            <br>
            It was pointed out to me that there is no Maintainer
            selection process or criteria defined.  This  will have to
            be sorted out before we move forward on this transition.<br>
            <br>
            <br>
            - armin<br>
            <br>
            <blockquote type="cite">
              <pre>- Armin



</pre>
              <br>
              <fieldset></fieldset>
            </blockquote>
            <br>
          </div>
          <br>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------C2905E87FB9E46D7559EF363--
