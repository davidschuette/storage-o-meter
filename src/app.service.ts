import { Injectable } from '@nestjs/common';
import { exec } from 'child_process';

@Injectable()
export class AppService {
  getHello(): Promise<string> {
    return new Promise((resolve, reject) => {

      const process = exec(`df -h / | tail -n 1 | awk '{ print $4,$5 }'`);
      let result = "Frei (absolut, relativ): ";
      
      process.stdout.on('data', (data: string) => {
        result += data
      });
      
      process.on('exit', () => {
        resolve(result);
      })
    })
  }
}
