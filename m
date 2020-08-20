Received: from NAM02-BL2-obe.outbound.protection.outlook.com (NAM02-BL2-obe.outbound.protection.outlook.com [40.107.75.49])
 by mx.groups.io with SMTP id smtpd.web10.117531.1597948426294614112
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2020 11:33:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=rYVf7UWw;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.75.49, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfiDIXWannch6a2vCdFg8QZJ+UcSPbT5R6NlEIDtaa0sixlotaWUaDWBzgIdx2RoAArdVqB+U4Zk8ngrA/QAe2NBEoB619Y5lYVMEB6zJhTgGHCzrPttSjOIHHNFWSKExN9AHvVtUk2yCaWElH21tHQSqVXxpCJqK0dXzy67+o38ZtOuhjpipoT/AkM3SR8Z6tzVODLkpdPPJrC2GyaEKLAYh57hwTmKKcpjJNhxdUkvNw6nRQUkbfj/PU5ger2qXifZRl8lsrWxOK7zgmeUyS0Kl+WnpLZUGH9pRpV6qjm4jiu6SbLTN6eCxw2VPZ5gfLBMImqHpSJncC2a8zo+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2dBBHhMIiDFjoUTVroEm+wB/ngNon/OA8rFHhH0o8k=;
 b=L2PhU0rbRZRBDoSH3PQzfWrxnS1agevJT8N9A0FqpEIHzMOZIhCkdLVsGetF9g2AG8dEW5PhnqfpFiQOyZFbFcmowQC/wpcUyDjclCkEO8uqyRPRA609lDMnDi+XcOZOUw35Oelq+yVk2ar4PdQuk8VBnnAImMzNJcwOAo8fcZ/eZtqu8GSgcqwyE/+twKRr8b9EQHncxDhtsXAy82h4lI6cx+3IySmhAvXxOTdgzN7ck8sKCk8DiK4ZJK94VXiN8WhVyy/t5eDtRPwtS1xuqOe1zQSn2UjngpYTJ9wTr/OxNXPm7ivF22JwvannNP69UrGi2w1hdc4vDVYoA07vEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2dBBHhMIiDFjoUTVroEm+wB/ngNon/OA8rFHhH0o8k=;
 b=rYVf7UWwrGScWHt5dT8B9aY3ND9rWKTtdkeXZah9hAm/nRHsFGDQ1kdsyu0dXtwngf0OkI8TBJT8okxG5V7+u+SSh+nG3/Cd8/Uq506Sk+Uu/kfIgPlRXbWTfySgq5leN1mtKt+djqkEPk/f7ong9l9i7VwjYg6jzYz0TrFGU4AIv41fV76JcG2eixoyiDVuhjfxd4M9hXRhiw0esVB6+L+VJ+TCKu0qE5lKWuPzurSpfEdSIGcGkJYDhp9XiWIxnJsk68CjTQIHVOagfMNY6uycp6HfnMLkP+yIbtg0HEg28hk2kSmChoqu3TgYEyJNMirX7UWcMAUklNcxN5VSMg==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:33:40 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 18:33:40 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
CC: "BitBake Development (bitbake-devel@lists.openembedded.org)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Problem with shell func backtracing and BB_VERBOSE_LOGS
Thread-Topic: Problem with shell func backtracing and BB_VERBOSE_LOGS
Thread-Index: AdZ3H5kzgzO3bGd5QKaII5Jeb0tgLwAAJtXwAAAMZxA=
Date: Thu, 20 Aug 2020 18:33:40 +0000
Message-ID: 
 <SN1PR12MB24804291B08431548D7AFC598B5A0@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <162D0D4E94A43CAA.19371@lists.openembedded.org>
 <1646d05d5e7740a79978cfcbda7966a6@XBOX03.axis.com>
In-Reply-To: <1646d05d5e7740a79978cfcbda7966a6@XBOX03.axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d7abe41-6268-406e-ae9d-08d845378fa8
x-ms-traffictypediagnostic: SN1PR12MB2576:
x-microsoft-antispam-prvs: 
 <SN1PR12MB2576EDEE8ADBB354F7972E6B8B5A0@SN1PR12MB2576.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1uR8K+Ro1s783F0nNhuA2KeYlh6EmsV/JI+9YRuFPU4vbIdgqYsgoJrh0i825F03fLrvER3dYK8eVkNHcmT6mksBpBJ0kIM6mkSL12Cc0xQUnCw8af/2lnBx4XiiesvUuU5Hw0YaFHeRD2YUnjTysx6OZ6HWnfnC7qpJEPzw7Jqu1IyGMcZdjKSPslnCcyzRw3mRsqrr5CWFgN+nM4ssEDJLLhjxJyW1co40QwbqH06qUWHZ0CXF+aLP1b5+Qc8iSyk+qeVnnOWYYbtaxLyIDqcsaWqyxknqqznXOm2co+6pQuOywGJLTvQeUbS9wZguiL6ecgzbotpy9CD3ZbhTBZl46OUuKBfzlbAE/PEq46RIAsGvcMYhUuq4vt94IW1i
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(29502001)(71200400001)(26005)(86362001)(6506007)(33656002)(186003)(7696005)(5660300002)(9686003)(316002)(2906002)(6916009)(66946007)(66446008)(66556008)(66476007)(64756008)(8676002)(76116006)(52536014)(8936002)(83380400001)(558084003)(55016002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 VyikNRXPotuC5bkwFxmk7Za1d/x2tmIyCGxhBXyU3qXE2ws9loCZNwu6aKClew8xTvZ911sFnViBYDJlR63WyeUVUeIKWsJzqWKzbz9I4suOWqcZhpIfJK4pRSPMH3ADMkuNRH7Us/t97CUEkeFS94DZGu5KW/Dbw20BMzwqberyqP32VuJfZrZ984371jPNWtQ7MRdPaMsbKi/TGIcxLCMf0sdUtxF74RkKUDnKAHAWpZoxc+fVIRZtyXbNeujOnIOSzlSUQlyB+lpL5Fjh1+UAtrdeMGIyD0UhbUix4zAxPHXfSBU7fVcgD+WmjK04kgQ4klWF+aCRE/OWSnj4W6DtiXoL7jp+AeB4TgDxLqFOuqdszcT20/KNZ2eykmIzpzRxV9mSQQi0rxt/1mqIqOqGH5bmwGbJ+t+jRzNo7Khvnqcyu/bVZQLyEvcwJVu9r4JG36uvMqF3XhaqIcaY/sKcj/GzxCtmlnCmOHU9xOjwy5PqERnowbomZO7wF/Xmh4rtCWRWWTAW9aIOfITCFpx6t7yj2+2Y8L/rCKdfyfoeJaNx+1bBS/bk/PSzGSjomNh5KZOAn5+NN2CwyjmBMaMKKtrqnBaqaVAMjNhFJIW7pqHrT4zmxWEYcBuJRYmTWPcn5My6wEvaYmuIw3p+KQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7abe41-6268-406e-ae9d-08d845378fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 18:33:40.7830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EecNmWviAi8+Hwilg9idxn3EmMRXyMuxSCUcrOUzEaLXXG8o6flNH6n00fMYB9NvbZlcDqXfhdpJ7dNHgVA7nb4Cswh3PiT8Jm0EN44A8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2576
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Bah, just ignore this. I just noticed that you have already sent a patch =
to fix
> this. :)
>=20
> //Peter
