import { CacheModule, Global, Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ConfigModule, ConfigService } from '@nestjs/config';
import configuration from './config/configuration';

@Global()
@Module({
  imports: [
    CacheModule.register({
      ttl: 900,
      isGlobal: true
    }),
    ConfigModule.forRoot({
      envFilePath: [
        process.env.NODE_ENV === 'development' ? '.env.development' : '.env.production',
      ],
      load: [configuration],
      isGlobal: true,
    }),
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (configService: any) => ({
        uri: configService.get('mongo_url'),
      }),
      inject: [ConfigService]
    }),
  ],
  exports: [CacheModule]
})
export class AppModule {}
